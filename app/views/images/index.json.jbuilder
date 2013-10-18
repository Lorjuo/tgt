json.array!(@images) do |image|
  json.extract! image, :name, :file, :attachable_id, :attachable_type
  json.url image_url(image, format: :json)
end
