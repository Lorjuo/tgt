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

class Image::Base < Asset

  # Associations
  belongs_to :attachable, polymorphic: true
  # Maybe rename this association to imageable, if documents and images keep separated or
  # rename this to assetable if both get joined


  # Specify database tablename
  self.table_name = 'images'


  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file

end
