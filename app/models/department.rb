class Department < ActiveRecord::Base
  extend FriendlyId
  
  #attr_accessible :area_id, :name, :training_group_ids

  # Associations
  has_many :documents
  has_and_belongs_to_many :flyers, :join_table => 'departments_flyers', :class_name => Document
  has_many :galleries
  has_many :messages
  has_many :navigation_elements
  has_many :training_groups
  #deprecated:
  #has_many :trainers, :through => :training_groups, :order => [ :first_name, :last_name ], :uniq => true
  #new syntax:
  has_many :trainers, -> { order('trainers.first_name, trainers.last_name') }, :through => :training_groups

  has_and_belongs_to_many :users#, through: :department_editor

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

  #def trainers
  #  Trainer.department(self.id)
  #end

end
