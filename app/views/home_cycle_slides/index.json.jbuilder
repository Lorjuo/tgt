json.array!(@home_cycle_slides) do |home_cycle_slide|
  json.extract! home_cycle_slide, :id, :name, :description, :url, :position
  json.url home_cycle_slide_url(home_cycle_slide, format: :json)
end
