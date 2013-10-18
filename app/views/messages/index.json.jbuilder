json.array!(@messages) do |message|
  json.extract! message, :title, :content, :department_id
  json.url message_url(message, format: :json)
end
