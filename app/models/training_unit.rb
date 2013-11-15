class TrainingUnit < ActiveRecord::Base
  scope :associations, -> {includes(:training_group, :weekday, :location_summer, :location_winter)}

  # Associations
  belongs_to :training_group
  # see: http://stackoverflow.com/questions/2606565/how-do-i-associate-one-model-twice-to-another
  belongs_to :location_summer, :class_name => 'Location'
  belongs_to :location_winter, :class_name => 'Location'

  # Validation
  validates :week_day, presence: true

  # Scopes
  scope :week_day, -> (id) { where(:week_day => id) }
  scope :chronological_time, -> { order(:time_begin => :asc).order(:time_end => :asc) }

  attr_accessor :daytime

  # Virtual attributes
  def name
    "#{week_day.name} + #{self.time}"
  end

  def time
    "#{I18n.l(time_begin, format: :time)} - "\
    "#{I18n.l(time_end, format: :time)}"
  end

  def display_week_day
    I18n.t(:"date.day_names").at(self.week_day)
  end
end
