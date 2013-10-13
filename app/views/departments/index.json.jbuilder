json.array!(@departments) do |department|
  json.extract! department, :name, :training_group_ids
  json.url department_url(department, format: :json)
end
