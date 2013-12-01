class Message < ActiveRecord::Base

  # Virtual temporal attributes for search
  attr_accessor :search_term

  # Associations
  belongs_to :department
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  #Scopes
  scope :department, -> (id) { where(:department_id => id)}
end
