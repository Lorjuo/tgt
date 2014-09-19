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

class Image < Asset

  # Associations
  belongs_to :attachable, polymorphic: true
  # Maybe rename this association to imageable, if documents and images keep separated or
  # rename this to assetable if both get joined
  # replicate this for header, banner, ...


  # Specify database tablename
  self.table_name = 'images'


  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file

  # http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
  class << self
    attr_accessor :width, :height, :preview_width, :preview_height
  end
end
