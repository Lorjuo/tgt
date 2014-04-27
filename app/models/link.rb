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
  has_one :banner, :as => :attachable, :class_name => 'Image::Banner', :dependent => :destroy

  belongs_to :linkable, polymorphic: true, :dependent => :destroy

  accepts_nested_attributes_for :banner, allow_destroy: true

  # Validation  
  validates :name, presence: true

  # def invoke_touch
  #   self.touch
  #   parent.invoke_touch unless parent.nil?
  # end
  
  delegate :url, :to => :linkable

end
