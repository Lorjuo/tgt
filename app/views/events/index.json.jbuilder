json.array!(@events) do |event|
  json.extract! event, :name, :term, :description
  json.url event_url(event, format: :json)
end
