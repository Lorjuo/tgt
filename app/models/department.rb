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
  has_many :trainers, -> { order('trainers.first_name, trainers.last_name').uniq }, :through => :training_groups

  has_and_belongs_to_many :users#, through: :department_editor

  # Validations
  validates :name, :presence => true

  # Scopes
  scope :specific, -> { where.not(name: 'generic') }

  friendly_id :name, use: :slugged

  #after_initialize :init
  after_create :init
  after_destroy :clean_up

  def init
    dir = File.join(Rails.public_path, 'files')+"/departments/#{self.id}"

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    unless self.name == 'generic'
      # see navigation_elements_controller
      # and http://rubydoc.info/gems/acts_as_tree/1.5.0/frames
      NavigationElement.create(:name => self.name, :parent_id => nil, :controller_id => 'departments', :action_id => 'show', :instance_id => self.id, :department_id => 1)

      #self.navigation_elements.new(:name, :parent_id, :controller_id, :action_id, :instance_id, :department_id)
      self.navigation_elements.create(:name => "Fotos", :parent_id => nil, :controller_id => 'departments', :action_id => 'galleries', :instance_id => self.id)
      self.navigation_elements.create(:name => "Trainingsgruppen", :parent_id => nil, :controller_id => 'departments', :action_id => 'training_groups', :instance_id => self.id)
      self.navigation_elements.create(:name => "Trainer", :parent_id => nil, :controller_id => 'departments', :action_id => 'trainers', :instance_id => self.id)
      self.navigation_elements.create(:name => "News", :parent_id => nil, :controller_id => 'departments', :action_id => 'messages', :instance_id => self.id)
      self.navigation_elements.create(:name => "Flyer", :parent_id => nil, :controller_id => 'departments', :action_id => 'flyers', :instance_id => self.id)
      # TODO: Events
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
