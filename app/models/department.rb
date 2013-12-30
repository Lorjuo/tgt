class Department < ActiveRecord::Base
  extend FriendlyId
  
  #attr_accessible :area_id, :name, :training_group_ids

  # Associations
  has_many :training_groups
  has_many :galleries
  has_many :messages
  has_and_belongs_to_many :users#, through: :department_editor
  has_many :navigation_elements
  has_and_belongs_to_many :flyers, :join_table => 'departments_flyers', :class_name => Document

  # Validations
  validates :name, :presence => true

  # Scopes
  scope :specific, -> { where.not(name: 'generic') }

  friendly_id :name, use: :slugged

  after_initialize :init
  after_destroy :clean_up

  def init
    dir = File.join(Rails.public_path, 'files')+"/departments/#{self.id}"

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end
  end

  def clean_up
    dir = File.join(Rails.public_path, 'files')+"/departments/#{self.id}"

    if File.directory?(dir)
      FileUtils.remove_dir(dir, :force => true)
    end
  end

end
