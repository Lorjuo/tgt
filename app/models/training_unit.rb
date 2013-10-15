class TrainingUnit < ActiveRecord::Base
  scope :associations, includes(:training_group, :weekday, :location_summer, :location_winter)

  # Associations
  belongs_to :weekday
  belongs_to :training_group
  # see: http://stackoverflow.com/questions/2606565/how-do-i-associate-one-model-twice-to-another
  belongs_to :location_summer, :class_name => 'Location'
  belongs_to :location_winter, :class_name => 'Location'

  # Validation

  # Virtual attributes
  def name
    "#{weekday.name} "\
      "(#{time_begin.strftime("%H:%M")}-"\
      "#{time_end.strftime("%H:%M")})"
  end
end
