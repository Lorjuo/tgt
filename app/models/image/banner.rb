class Image::Banner < Image::Base

  # Uploader
  mount_uploader :file, ::Image::BannerUploader, :mount_on => :file
  crop_uploaded :file
end