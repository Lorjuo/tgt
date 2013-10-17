# encoding: utf-8
class DocumentUploader < BaseUploader
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{partition(model.id)}"
  end
  
end
