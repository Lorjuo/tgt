class Message < ActiveRecord::Base

  # Virtual temporal attributes for search
  attr_accessor :search_term

  # Associations
  belongs_to :department
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  # References
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  accepts_nested_attributes_for :image, allow_destroy: true

  #Scopes
  scope :department, -> (id) { where(:department_id => id)}
  scope :chronological, -> { order("created_at" => :desc) }

  after_initialize :default_values
  # http://stackoverflow.com/questions/9090204/rails-migration-set-current-date-as-default-value
  def default_values
    self.custom_date ||= Date.today.to_s if new_record?
  end

  def display_abstract( options={} )
    options.reverse_merge! :text_length => 240
    if self.abstract.present?
      self.abstract
    else
      ActionController::Base.helpers.truncate(
        ActionController::Base.helpers.strip_tags(self.content),
        length: options[:text_length], omission: '', :separator => ' ')
    end
  end
end
