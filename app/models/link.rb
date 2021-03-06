# == Schema Information
#
# Table name: links
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  parent_id     :integer
#  lft           :integer
#  rgt           :integer
#  depth         :integer
#  department_id :integer
#  linkable_id   :integer
#  linkable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean          default(TRUE)
#  theme_id      :integer
#

class Link < ActiveRecord::Base # Parent Class for polymorphic association
  include TheSortableTree::Scopes
  #include Rails.application.routes.url_helpers
  #include ActionController::PolymorphicRoutes

  # Scopes
  # default_scope { active } # Does not work for some reasons
  scope :active, -> { where(:active => true) } # TODO: make this functionality working
  scope :department, -> (id) { where(:department_id => id)}
  #scope :top_level, -> { where(:department_id => nil)}
  #scope :top_level, -> { where(:department_id => Department.where(:name => "generic").first.id)}
  scope :top_level, -> { joins(:department).where('departments.name' => 'generic')}

  # Columns in the categories table: lft, rgt and parent_id
  acts_as_nested_set  :scope => :department_id,
                      touch: true
                      #:after_add      => :invoke_touch, # these callbacks seem not to be triggered
                      #:after_remove   => :invoke_touch
  
  # Invoke touch on parent, to update timestamp for fragment caching
  # declaring this in the association is not possible:
  # see: https://github.com/collectiveidea/awesome_nested_set/blob/master/lib/awesome_nested_set/awesome_nested_set.rb, line 66
  #before_save :invoke_touch
  #before_destroy :invoke_touch
  #after_save :invoke_touch
  #after_destroy :invoke_touch
  
  # Associations
  belongs_to :department

  belongs_to :theme

  belongs_to :linkable, polymorphic: true, :dependent => :delete
  # NOTE: :dependent => :destroy leads to an endless loop
  # https://github.com/rails/rails/issues/13609

  # Validation  
  validates :name, presence: true

  # def invoke_touch
  #   self.touch
  #   parent.invoke_touch unless parent.nil?
  # end
  
  delegate :url, :to => :linkable

  def get_theme
    if self.theme.present?
      self.theme
    elsif self.parent.present?
      self.parent.get_theme
    else
      self.department.get_theme
    end
  end

  def get_label
    active_label = active ? "" : "("+I18n.t('general.inactive')+")"
    "#{name} #{active_label}"
  end

  def get_tree_classes
    linkable_type + " " + (active ? "active" : "inactive")
  end

end
