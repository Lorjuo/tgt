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
end

