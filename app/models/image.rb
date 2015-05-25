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


# ABSTRACT MODEL - OBJECTS SHOULD ONLY BE INSTANCIATED FROM CHILD CLASSES

class Image < Asset

  # Associations
  belongs_to :attachable, polymorphic: true, touch: true # touch attachment host object to prevent caching problems when images get recreated
  # Maybe rename this association to imageable, if documents and images keep separated or
  # rename this to assetable if both get joined
  # replicate this for header, banner, ...


  # Specify database tablename
  self.table_name = 'images' # neccessary for STI -> affects child classes

  # Uploader
  #mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file

  def aspect_ratio
    return self.width.to_f / self.height
  end

  # http://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables/1251422#1251422
  class << self
    attr_accessor :thumb_width, :thumb_height, :crop_width, :crop_height, :preview_width, :preview_height, :croppable
  end

  # We will need a way to know which types
  # will subclass the Image model
  def self.races
    %w(Image::Banner Image::Header Image::Poster Image::Photo Image::GalleryPhoto)
  end

  # ATTENTION - THIS IS REALLY IMPORTANT:
  # 
  # This prevents urls created from instances of subclasses to have scoped paths or urls when using url helpers
  # this affects the module "Image" althoug it is defined inside the class "Image"
  # This also causes the form parameters to exclude the module name
  # 
  # https://github.com/rails/rails/issues/10705
  # http://stackoverflow.com/questions/11127426/rails-3-polymorphic-path-how-to-change-the-default-route-key
  # http://stackoverflow.com/a/13261518/871495
  def self.use_relative_model_naming?
    true
  end
end
Image.croppable = false
