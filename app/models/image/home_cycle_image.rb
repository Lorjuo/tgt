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



class Image::HomeCycleImage < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::HomeCycleUploader, :mount_on => :file
  crop_uploaded :file

  # http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
  # class << self
  #   attr_accessor :width, :height, :preview_width, :preview_height
  # end
end

# http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
Image::HomeCycleImage.thumb_width = 1200
Image::HomeCycleImage.thumb_height = 400
Image::HomeCycleImage.crop_width = 400
Image::HomeCycleImage.crop_height = 400
Image::HomeCycleImage.preview_width = 360
Image::HomeCycleImage.preview_height = 120
Image::HomeCycleImage.croppable = true
