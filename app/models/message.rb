class Message < ActiveRecord::Base

  # Virtual temporal attributes for search
  attr_accessor :search_term

  # Associations
  belongs_to :department
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  has_many :references
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  accepts_nested_attributes_for :image, allow_destroy: true

  #Scopes
  scope :department, -> (id) { where(:department_id => id)}
end
