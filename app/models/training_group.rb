class TrainingGroup < ActiveRecord::Base
  #scope :associations, includes(:department, :trainers, :training_units)
  
  #attr_accessible :age_begin, :age_end, :ancient, :description, :name, :department_id, :training_units_attributes, :trainer_ids

  # Associations
  belongs_to :department
  has_and_belongs_to_many :trainers
  has_many :training_units
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  accepts_nested_attributes_for :training_units, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :image, allow_destroy: true

  # Validation
  validates :name, :presence => true
  validates :age_begin, :presence => true, :numericality => { :only_integer => true }
  validates :age_end, :presence => true, :numericality => { :only_integer => true }
  validates_with AgeRangeValidator
  #validates :end_date, :date => {:after => {:message => "must be after the start date", :value => lambda { |batch|  batch.start_date}}}

  # Scopes
  scope :ancient, -> { where(:ancient => true)}
  scope :current, -> { where(:ancient => false)}

  attr_accessor :start_date_time, :closing_date, :begin_at # TODO: Remove this line

  # Virtual attributes
  def age
    valid_begin = 0 < age_begin && age_begin < 99
    valid_end= 0 < age_end && age_end < 99

    if valid_begin && valid_end
      I18n.t "general.age.range", :begin => age_begin, :end => age_end

    elsif valid_begin
      I18n.t "general.age.begin", :begin => age_begin

    elsif valid_end
      I18n.t "general.age.end", :end => age_end
      
    else
      I18n.t "general.age.unlimited"
    end
  end
end
