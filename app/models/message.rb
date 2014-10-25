# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  content       :text
#  department_id :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  abstract      :text
#  custom_date   :date
#  visible_from  :date
#  visible_to    :date
#  published     :boolean
#

class Message < ActiveRecord::Base

  # Virtual temporal attributes for search
  attr_accessor :search_term

  # Associations
  belongs_to :department
  has_one :thumb, :as => :attachable, :class_name => 'Image', :dependent => :destroy
  has_one :header, :as => :attachable, :class_name => 'Image::Header', :dependent => :destroy
  # Multiple Associations to same polymorphic model:
  # http://stackoverflow.com/questions/2494452/rails-polymorphic-association-with-multiple-associations-on-the-same-model

  # References
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  accepts_nested_attributes_for :thumb, allow_destroy: true
  accepts_nested_attributes_for :header, allow_destroy: true

  # Scopes
  scope :department, -> (id) { where(:department_id => id)}
  scope :chronological, -> { order("created_at" => :desc) }
  scope :published, -> { where(:published => true) }
  scope :visible, -> {
    where("visible_from IS NULL OR visible_from <= ?", Date.today)
    .where("visible_to IS NULL OR visible_to >= ?", Date.today)
  }

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
        length: options[:text_length], escape: false, omission: '', :separator => ' ')
    end
  end

  def display_visible
    valid_begin = visible_from.present?
    valid_end = visible_to.present?

    if valid_begin && valid_end
      "#{visible_from} #{visible_to}"

    elsif valid_begin
      I18n.t("general.date_formats.begin")+" "+I18n.l(visible_from, :format => :default )

    elsif valid_end
      I18n.t("general.date_formats.end")+" "+I18n.l(visible_to, :format => :default )
      
    else
      I18n.t "general.always"
    end
  end

  # Validations
  validates :name, :presence => true
  validates_date :visible_from, :allow_blank => true
  validates_date :visible_to, :allow_blank => true, :after => :visible_from
end
