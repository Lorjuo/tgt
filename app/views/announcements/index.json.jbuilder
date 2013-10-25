json.array!(@announcements) do |announcement|
  json.extract! announcement, :name, :content, :link, :active
  json.url announcement_url(announcement, format: :json)
end
