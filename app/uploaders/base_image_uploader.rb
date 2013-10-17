# encoding: utf-8
class BaseImageUploader < BaseUploader
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  after :store, :unlink_original
  
  process quality: 90

  process resize_to_fit: [800, 600]

  process :set_content_type

  def extension_white_list
    %w(jpg jpeg gif png tiff)
  end

  def unlink_original(file)
    File.delete if version_name.blank?
  end

end