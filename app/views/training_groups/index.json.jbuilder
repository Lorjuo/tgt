json.array!(@training_groups) do |training_group|
  json.extract! training_group, :name, :description, :department_id, :age_begin, :age_end
  json.url training_group_url(training_group, format: :json)
end
