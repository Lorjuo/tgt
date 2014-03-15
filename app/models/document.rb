class Document < ActiveRecord::Base

  # Associations
  belongs_to :department
  belongs_to :attachable, polymorphic: true
  has_many :references, :as => :reference_to, :dependent => :destroy # polymorphic

  # Uploader
  mount_uploader :file, DocumentUploader, :mount_on => :file

  before_create :default_name
  before_update :default_name

  #Scopes
  scope :department, -> (id) { where(:department_id => id)}
  scope :chronological, -> { order("created_at" => :desc) }

  def default_name
    # file.filename replaced by file.original_file
    if(self.name.blank?)
      self.name = File.basename(file.original_file, '.*').titleize if file
    end
  end

  def self.document_list
    all.map{ |doc| [doc.name, doc.file.url] }
  end
end
