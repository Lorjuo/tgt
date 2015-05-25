class Image::GalleryImage < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::GalleryUploader, :mount_on => :file
  crop_uploaded :file

  # will_paginate
  self.per_page = 12
end

Image::GalleryImage.thumb_width = 240
Image::GalleryImage.thumb_height = 180
Image::GalleryImage.crop_width = 400
Image::GalleryImage.crop_height = 400
Image::GalleryImage.preview_width = 400
Image::GalleryImage.preview_height = 300
Image::GalleryImage.croppable = true
