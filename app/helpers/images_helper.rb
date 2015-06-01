module ImagesHelper

  #http://stackoverflow.com/questions/10325521/carrierwave-polymorphic-with-default-url-issue
  #def image_url(image, size)
  #  #image.file.url(size)
  #  defined?(image.file) ? image.file.url(size) : Image::PhotoUploader.new.send(size).default_url
  #end

  def image_url(*args)
    #http://stackoverflow.com/questions/4967735/ruby-method-with-maximum-number-of-parameters
    #http://www.rubydoc.info/github/jnicklas/carrierwave/master/CarrierWave/Uploader/Versions:url
    
    # WHERE file_url accepts nil as second parameter -> but does not seem to work correctly
    
    image, version, subversion = *args
    versions = *args[1..-1]

    if defined?(image.file)
      if subversion.present?
        image.file.send(version).send(subversion).url
      else
        image.file.send(version).url
      end
    else
      #http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/
      if subversion.present?
        Image::PhotoUploader.new.send(version).send(subversion).default_url
      else
        Image::PhotoUploader.new.send(version).default_url
      end
    end
  end

  def fallback_url(size)
    Image::PhotoUploader.new.send(size).default_url
  end

end
