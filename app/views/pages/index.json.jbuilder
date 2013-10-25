json.array!(@pages) do |page|
  json.extract! page, :name, :department_id, :content
  json.url page_url(page, format: :json)
end
