json.full_image				@image.file.url
if @preview_version.present?
  json.preview_image    @image.file.cropped.send(@preview_version).url
else
  json.preview_image    @image.file.cropped.url
end