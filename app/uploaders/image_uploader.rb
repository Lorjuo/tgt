# encoding: utf-8
class ImageUploader < BaseUploader
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  #http://makandracards.com/makandra/12323-carrierwave-auto-rotate-tagged-jpegs
  process :fix_exif_rotation # this should go before all other "process" steps
  after :store, :unlink_original
  
  process quality: 80 #https://github.com/petedoyle/imagemagick-quality-tests

  process :strip_exif_metadata
  process :set_content_type

  def store_dir
    #parent_id = model.tmp_parent_id ? model.tmp_parent_id : model.attachable.id

    # versions seems to depend on the "store_dir" function in current uploader class or its parents
    # therefore it should be defined in a base class instead of a sub class when versions are defined in both
    if(model.class.name.demodulize.underscore == 'gallery_image')
      "uploads/"\
      "#{model.attachable.class.to_s.underscore}/"\
      "#{model.attachable.id.to_s}/"\
      "#{model.id.to_s}"
    else
      "uploads/"\
      "#{model.class.to_s.demodulize.underscore}/"\
      "#{model.id.to_s}"
    end

    # "uploads/"\
    # "#{model.attachable.class.to_s.underscore}/"\
    # "#{model.attachable.id.to_s}/"\
    # "#{model.class.to_s.demodulize.underscore}/"\
    # "#{model.id.to_s}"

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
    # (store_dir+'/'+original_file)
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

  # http://makandracards.com/makandra/12323-carrierwave-auto-rotate-tagged-jpegs
  # http://stackoverflow.com/questions/18519160/exif-image-rotation-issue-using-carrierwave-and-rmagick-to-upload-to-s3
  # http://stackoverflow.com/questions/9558653/rails-paperclip-and-upside-down-oriented-images
  # https://gist.github.com/tanraya/7438337
  def fix_exif_rotation
    manipulate! do |img|
      img.tap(&:auto_orient)
      img = yield(img) if block_given?
      img
    end
  end

  # Versions
  # Thumb version needed for image selector
  #version :thumb do
  #  process resize_to_fill: [64, 48]
  #end

  # Store image dimensions
  # http://stackoverflow.com/questions/12022653/ruby-on-rails-carrierwave-get-the-image-dimension-width-and-height
  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Get-image-dimensions
  def store_dimensions
    if file && model
      model.width, model.height = `identify -format "%wx%h" #{file.path}`.split(/x/)
    end
  end

end