json.array!(@training_units) do |training_unit|
  json.extract! training_unit, :weekday, :time_begin, :time_end, :location_summer_id, :location_winter_id
  json.url training_unit_url(training_unit, format: :json)
end
