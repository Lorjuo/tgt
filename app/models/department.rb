class Department < ActiveRecord::Base
  extend FriendlyId
  
  #attr_accessible :area_id, :name, :training_group_ids

  # Associations
  has_many :training_groups
  has_many :messages
  has_and_belongs_to_many :users#, through: :department_editor
  has_many :pages

  # Validations
  validates :name, :presence => true

  # Scopes
  scope :specific, -> { where.not(name: 'generic') }

  friendly_id :name, use: :slugged
end
