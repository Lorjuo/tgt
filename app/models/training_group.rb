# == Schema Information
#
# Table name: training_groups
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text
#  department_id :integer
#  age_begin     :integer
#  age_end       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  ancient       :boolean
#

class TrainingGroup < ActiveRecord::Base
  #scope :associations, includes(:department, :trainers, :training_units)
  
  #attr_accessible :age_begin, :age_end, :ancient, :description, :name, :department_id, :training_units_attributes, :trainer_ids

  # Associations
  belongs_to :department
  has_and_belongs_to_many :trainers
  has_many :training_units
  has_one :photo, :as => :attachable, :class_name => 'Image::Photo', :dependent => :destroy
  
  # References
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  accepts_nested_attributes_for :training_units, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :photo, allow_destroy: true

  attr_accessor :photo_id

  # Virtual temporal attributes for search
  attr_accessor :departments, :week_days, :age, :keywords

  # Validation
  validates :name, :presence => true
  validates :age_begin, :presence => true, :numericality => { :only_integer => true }
  validates :age_end, :presence => true, :numericality => { :only_integer => true }
  validates_with AgeRangeValidator
  #validates :end_date, :date => {:after => {:message => "must be after the start date", :value => lambda { |batch|  batch.start_date}}}

  # Scopes
  scope :ancient, -> { where(:ancient => true)}
  scope :current, -> { where(:ancient => false)}
  scope :age, -> (age) {
    where("age_begin IS NULL"\
    " OR age_begin <= 0"\
    " OR age_begin >= 99"\
    " OR age_begin <= ?", age)
    .where("age_end IS NULL"\
    " OR age_end <= 0"\
    " OR age_end >= 99"\
    " OR age_end >= ?", age)
  }
  scope :chronological, -> { order(:age_begin => :asc, :age_end => :asc) }
  scope :alphabetical, -> { order(:name => :asc)}

  # Virtual attributes
  def display_age
    valid_begin = 0 < age_begin && age_begin < 99
    valid_end = 0 < age_end && age_end < 99

    if valid_begin && valid_end
      I18n.t "general.age_formats.range", :begin => age_begin, :end => age_end

    elsif valid_begin
      I18n.t "general.age_formats.begin", :begin => age_begin

    elsif valid_end
      I18n.t "general.age_formats.end", :end => age_end
      
    else
      I18n.t "general.age_formats.unlimited"
    end
  end
end
