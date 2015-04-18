class Image::GalleryImage < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::GalleryUploader, :mount_on => :file
  crop_uploaded :file

  # will_paginate
  self.per_page = 12
end

Image::GalleryImage.width = 1088
Image::GalleryImage.height = 148
Image::GalleryImage.preview_width = 544
Image::GalleryImage.preview_height = 74
Image::GalleryImage.croppable = true
