json.array!(@navigation_elements) do |navigation_element|
  json.extract! navigation_element, :title
  json.url navigation_element_url(navigation_element, format: :json)
end
