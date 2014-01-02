class NavigationElement < ActiveRecord::Base
  include TheSortableTree::Scopes
  include Rails.application.routes.url_helpers
  #include ActionController::PolymorphicRoutes

  scope :department, -> (id) { where(:department_id => id)}
  #scope :top_level, -> { where(:department_id => nil)}
  scope :top_level, -> { where(:department_id => 0)}

  # Columns in the categories table: lft, rgt and parent_id
  acts_as_nested_set  :scope => :department_id#,
                      #:after_add      => :invoke_touch, # these callbacks seem not to be triggered
                      #:after_remove   => :invoke_touch

  # Invoke touch on parent, to update timestamp for fragment caching
  # declaring this in the association is not possible:
  # see: https://github.com/collectiveidea/awesome_nested_set/blob/master/lib/awesome_nested_set/awesome_nested_set.rb, line 66
  #before_save :invoke_touch
  #before_destroy :invoke_touch
  
  # Associations
  belongs_to :department

  # Validation  
  validates :name, presence: true
  validates :action_id, presence: true, :unless => :is_anchor?
  #validates :instance_id, presence: true, :unless => :is_anchor? #lambda{ state == 'invalid' }

  def is_anchor?
    #debugger
    #controller_id.empty?
    controller_id == ''
  end

  def invoke_touch
    self.touch
    parent.invoke_touch unless parent.nil?
  end

  # Return relative url for given navigation element
  def url
    # TODO bug with controllers without models e.g. StaticPages
    if controller_id.empty?
      "#"
    elsif instance_id.nil?
      url_for :controller => controller_id, :action => action_id, :only_path => true
    else
      # http://stackoverflow.com/questions/5316290/get-model-class-from-symbol
      klass = controller_id.classify.constantize
      if instance_id.present?
        instance = klass.find(instance_id)

        if ["show"].include? action_id
          polymorphic_path(instance, :only_path => true)
        else
          polymorphic_path(instance, :action => action_id, :only_path => true)
        end
      end
    end
  end
end
