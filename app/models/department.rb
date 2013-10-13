class Department < ActiveRecord::Base
  #attr_accessible :area_id, :name, :training_group_ids

  # Associations
  has_many :training_groups
  has_many :messages
  has_and_belongs_to_many :users#, through: :department_editor

  # Validations
  validates :name, :presence => true
end