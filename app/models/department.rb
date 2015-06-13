# == Schema Information
#
# Table name: departments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  training_group_ids :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  description        :text
#  color              :string(255)
#  theme_id           :integer
#  area_id            :integer
#

class Department < ActiveRecord::Base
  extend FriendlyId

  include StringHelper
  
  #attr_accessible :area_id, :name, :training_group_ids

  # Associations
  has_many :documents
  # has_and_belongs_to_many :flyers, :join_table => 'departments_flyers', :class_name => Document
  has_many :events
  has_many :quick_links
  has_many :galleries
  has_many :messages
  has_many :training_groups
  #deprecated:
  #has_many :trainers, :through => :training_groups, :order => [ :first_name, :last_name ], :uniq => true
  #new syntax:
  has_many :trainers, -> { order('trainers.first_name, trainers.last_name').uniq }, :through => :training_groups
  has_one :banner, :as => :attachable, :class_name => 'Image::Banner', :dependent => :destroy

  has_many :links#; has_many :media_links; has_many :extern_links

  has_and_belongs_to_many :users#, through: :department_editor
  
  #accepts_nested_attributes_for :banner, allow_destroy: true

  #attr_accessor :banner_id

  belongs_to :theme
  belongs_to :area

  # Validations
  validates :name, :presence => true

  # Scopes
  scope :specific, -> { where.not(name: 'generic') }
  scope :alphabetical, -> { order("name") }

  friendly_id :name, use: :slugged

  #after_initialize :init
  #after_create :init
  after_destroy :clean_up

  def init
    create_directory_structure

    # self.name does not work with tests
    create_navigation_structure unless name == 'generic' 
  end

  def create_navigation_structure
    # see navigation_elements_controller
    # and http://rubydoc.info/gems/acts_as_tree/1.5.0/frames
    # 
    # NavigationElement.create(:name => name, :parent_id => nil, :controller_id => 'departments', :action_id => 'show', :instance_id => id, :department_id => 1)

    # #navigation_elements.new(:name, :parent_id, :controller_id, :action_id, :instance_id, :department_id)
    # navigation_elements.create(:name => "Fotos", :parent_id => nil, :controller_id => 'departments', :action_id => 'galleries', :instance_id => id)
    # navigation_elements.create(:name => "Trainingsgruppen", :parent_id => nil, :controller_id => 'departments', :action_id => 'training_groups', :instance_id => id)
    # navigation_elements.create(:name => "Trainer", :parent_id => nil, :controller_id => 'departments', :action_id => 'trainers', :instance_id => id)
    # navigation_elements.create(:name => "News", :parent_id => nil, :controller_id => 'departments', :action_id => 'messages', :instance_id => id)
    # navigation_elements.create(:name => "Dokumente", :parent_id => nil, :controller_id => 'departments', :action_id => 'documents', :instance_id => id)
    # TODO: Events
    
    #MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'show').create_link(:department_id => 1, :name => name, :parent_id => nil).save!

    MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'messages').create_link(:department_id => id, :name => 'Aktuelles', :parent_id => nil).save!
    MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'training_groups').create_link(:department_id => id, :name => 'Trainingsgruppen', :parent_id => nil).save!
    MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'trainers').create_link(:department_id => id, :name => 'Trainer', :parent_id => nil).save!
    MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'galleries').create_link(:department_id => id, :name => 'Fotos', :parent_id => nil).save!
    MediaLink.create(:controller_id => 'departments', :instance_id => id, :action_id => 'documents').create_link(:department_id => id, :name => 'Dokumente', :parent_id => nil).save!
  end

# controller_id :string(255)
# #  instance_id   :integer
# #  action_id     :string(255)
#     delegate :department, :to => :link
#     delegate :name, :to => :link
#     delegate :parent, :to => :link
#     delegate :active, :to => :link

  # Department.all.each{|dep| dep.create_directory_structure}
  def create_directory_structure

    # self.name does not work with tests
    if name == 'generic'
      department_name = 'verein'
    else
      department_name = slug #sanitize_filename(self.name).strip.squish
    end
    puts department_name

    root_dir = File.join(Rails.public_path, 'files')+"/#{department_name}/"

    # mkdir_p: Creates a directory and all its parent directories

    directories = ['Seiten/_Beispielseite',
      'Veranstaltungen/2001_Beispielveranstaltung',
      'Nachrichten/2001_01_01_Beispielnachricht',
      # 'Ankuendigungen/2001_01_01_Beispielankuendigung',
      'Sonstiges/_Beispielordner'
    ]

    directories.each do |dir|
      FileUtils.mkdir_p(root_dir+dir) unless File.directory?(root_dir+dir)
    end
  end

  def clean_up
    dir = File.join(Rails.public_path, 'files')+"/departments/#{self.id}"

    if File.directory?(dir)
      FileUtils.remove_dir(dir, :force => true)
    end
  end

  def get_theme
    self.theme
  end

end
