# encoding: utf-8
require 'carrierwave/processing/mime_types'
class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
 
  # TODO: delete empty dirs:
  # https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Make-a-fast-lookup-able-storage-directory-structure

  storage :file
  # if Rails.env.test?
  #   storage :file
  # else
  #   storage :fog
  # end
  
  # Move files instead of copying for better performance
  def move_to_cache
    true
  end
  def move_to_store
    true
  end
  
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def filename
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present? # "unless" insted of "if"? - but seems to work
  end

  # TODO: this function does not really work in asset.rb -> insted original_filename is directly accessible
  def original_file # Accessor for probably protected value original_filename
    original_filename
  end

  # https://github.com/carrierwaveuploader/carrierwave#providing-a-default-url
  # Maybe move this to image uploader
  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #ActionController::Base.helpers.asset_path("fallback/" + "default.gif")
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

  protected

  # Create unique filename
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end