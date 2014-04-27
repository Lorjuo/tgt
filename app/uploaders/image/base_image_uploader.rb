# encoding: utf-8
class Image::BaseImageUploader < BaseUploader
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  after :store, :unlink_original
  
  process quality: 80 #https://github.com/petedoyle/imagemagick-quality-tests

  process resize_to_fit: [800, 600]
  process :strip_exif_metadata
  process :set_content_type

  def store_dir
    #parent_id = model.tmp_parent_id ? model.tmp_parent_id : model.attachable.id
    "uploads/"\
    "#{model.attachable.class.to_s.underscore}/"\
    "#{model.attachable.id.to_s}/"\
    "#{model.class.to_s.demodulize.underscore}/"\
    "#{model.id.to_s}"
    # demodulize: strip namespace
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff)
  end

  # remove original file:
  # https://github.com/jnicklas/carrierwave/issues/584
  # http://stackoverflow.com/questions/9557911/how-to-delete-the-original-files-and-keep-only-the-versions
  def unlink_original(file)
    File.delete if version_name.blank?
  end

  # http://stackoverflow.com/questions/4753408/how-to-remove-exif-camera-data-from-image-with-carrierwave
  # Strip EXIF Metadata to get smaller file sizes
  def strip_exif_metadata
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  # Versions
  # Thumb version needed for image selector
  version :thumb do
    process resize_to_fill: [64, 48]
  end

end