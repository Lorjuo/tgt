class Document::Base < Asset

  # Associations
  belongs_to :department
  belongs_to :attachable, polymorphic: true
  has_many :references, :as => :reference_to, :dependent => :destroy # polymorphic
  # Maybe extract department and references into another more specific model,
  # that references to Document::Base


  # Carrierwave Uploader
  mount_uploader :file, ::Document::BaseUploader, :mount_on => :file


  # Scopes
  scope :department, -> (id) { where(:department_id => id)}
end
# COMPLETED
