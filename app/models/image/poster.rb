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

class Image::Poster < Image
  
  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::PosterUploader, :mount_on => :file
end
