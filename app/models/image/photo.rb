# == Schema Information
#
# Table name: images
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  file            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string(255)
#  type            :string(255)
#


class Image::Photo < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file
  crop_uploaded :file
end

# http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
Image::Photo.thumb_width = 240
Image::Photo.thumb_height = 180
Image::Photo.crop_width = 400
Image::Photo.crop_height = 600
Image::Photo.preview_width = 400
Image::Photo.preview_height = 300
Image::Photo.croppable = true
