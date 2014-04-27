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

class Image::Banner < Image::Image

  # Uploader
  mount_uploader :file, ::Image::BannerUploader, :mount_on => :file
  crop_uploaded :file

  # http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
  class << self
    attr_accessor :width, :height, :preview_width, :preview_height
  end
end

# http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
Image::Banner.width = 1088
Image::Banner.height = 148
Image::Banner.preview_width = 544
Image::Banner.preview_height = 74
