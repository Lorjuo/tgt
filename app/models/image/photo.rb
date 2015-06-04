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
#  width           :integer
#  height          :integer
#  file_crop_x     :float(24)
#  file_crop_y     :float(24)
#  file_crop_w     :float(24)
#  file_crop_h     :float(24)
#



class Image::Photo < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file
  crop_uploaded :file
end

# http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
Image::Photo.thumb_width = 300 # probably not needed atm
Image::Photo.thumb_height = 200 # probably not needed atm
Image::Photo.crop_width = 400 # max crop area - should be always 400/600
Image::Photo.crop_height = 600
Image::Photo.preview_width = 400 # preview box width - should be same as crop width
Image::Photo.preview_height = 277 # height should be adjusted to fit crop image ratio
Image::Photo.croppable = true
