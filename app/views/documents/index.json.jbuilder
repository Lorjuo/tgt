json.array!(@documents) do |document|
  json.extract! document, :name, :file, :documentable_id, :documentable_type
  json.url document_url(document, format: :json)
end
