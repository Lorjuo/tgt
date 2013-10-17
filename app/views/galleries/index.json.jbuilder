json.array!(@galleries) do |gallery|
  json.extract! gallery, :name
  json.url gallery_url(gallery, format: :json)
end
