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

  def width
    1088
  end

  def height
    148
  end
end
