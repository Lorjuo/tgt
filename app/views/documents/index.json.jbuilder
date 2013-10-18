json.array!(@documents) do |document|
  json.extract! document, :name, :file, :attachable_id, :attachable_type
  json.url document_url(document, format: :json)
end
