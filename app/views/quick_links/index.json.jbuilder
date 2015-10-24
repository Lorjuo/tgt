json.array!(@quick_links) do |quick_link|
  json.extract! quick_link, :id, :name, :url, :department_id
  json.url quick_link_url(quick_link, format: :json)
end
