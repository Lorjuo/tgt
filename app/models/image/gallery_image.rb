class Image::GalleryImage < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file
  crop_uploaded :file

  # will_paginate
  self.per_page = 12
end