json.array!(@images) do |image|
  json.extract! image, :name, :file, :imageable_id, :imageable_type
  json.url image_url(image, format: :json)
end
