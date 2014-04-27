# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  content       :text
#  department_id :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  abstract      :text
#  custom_date   :date
#

class Message < ActiveRecord::Base

  # Virtual temporal attributes for search
  attr_accessor :search_term

  # Associations
  belongs_to :department
  has_one :thumb, :as => :attachable, :class_name => 'Image::Image', :dependent => :destroy
  has_one :header, :as => :attachable, :class_name => 'Image::Header', :dependent => :destroy
  # Multiple Associations to same polymorphic model:
  # http://stackoverflow.com/questions/2494452/rails-polymorphic-association-with-multiple-associations-on-the-same-model

  # References
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  accepts_nested_attributes_for :thumb, allow_destroy: true
  accepts_nested_attributes_for :header, allow_destroy: true

  #Scopes
  scope :department, -> (id) { where(:department_id => id)}
  scope :chronological, -> { order("created_at" => :desc) }

  after_initialize :default_values
  # http://stackoverflow.com/questions/9090204/rails-migration-set-current-date-as-default-value
  def default_values
    # self.custom_date does not work with tests
    custom_date ||= Date.today.to_s if new_record?
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
