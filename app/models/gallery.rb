class Gallery < ActiveRecord::Base

  # Associations
  belongs_to :department
  has_many :images, :as => :attachable, :class_name => '::Image', dependent: :destroy
  belongs_to :preview_image, :class_name => '::Image'
  
  # References
  has_many :references, :as => :reference_to, :dependent => :destroy # polymorphic
  has_many :messages, :through => :references, :source => :reference_from, :source_type => 'Message'

  accepts_nested_attributes_for :images, allow_destroy: true

  # Validation
  validates :name, :presence => true

  #Scopes
  scope :chronological, -> { order("created_at" => :desc) }

  def get_preview_image
    self.preview_image || self.images.first
  end
end
