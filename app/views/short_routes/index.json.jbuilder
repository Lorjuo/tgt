json.array!(@short_routes) do |short_route|
  json.extract! short_route, :id, :name, :url, :http
  json.url short_route_url(short_route, format: :json)
end
