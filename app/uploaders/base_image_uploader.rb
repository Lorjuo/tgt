# encoding: utf-8
class BaseImageUploader < BaseUploader
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  after :store, :unlink_original
  
  process quality: 80 #https://github.com/petedoyle/imagemagick-quality-tests

  process resize_to_fit: [800, 600]
  process :strip
  process :set_content_type

  def extension_white_list
    %w(jpg jpeg gif png tiff)
  end

  def unlink_original(file)
    File.delete if version_name.blank?
  end

  # http://stackoverflow.com/questions/4753408/how-to-remove-exif-camera-data-from-image-with-carrierwave
  # Strip EXIF Metadata to get smaller file sizes
  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

end