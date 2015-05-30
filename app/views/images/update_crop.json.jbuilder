json.full_image				format_content(@image.file.url)
json.preview_image		format_content(@image.file.cropped.send(preview_version).url)