module ImagesHelper

  #http://stackoverflow.com/questions/10325521/carrierwave-polymorphic-with-default-url-issue
  #def image_url(image, size)
  #  #image.file.url(size)
  #  defined?(image.file) ? image.file.url(size) : Image::PhotoUploader.new.send(size).default_url
  #end

  def image_url(*args)
    #http://stackoverflow.com/questions/4967735/ruby-method-with-maximum-number-of-parameters
    #http://www.rubydoc.info/github/jnicklas/carrierwave/master/CarrierWave/Uploader/Versions:url
    
    image, version, subversion = *args
    versions = *args[1..-1]

    if defined?(image.file)
      image.file.url(versions)
    else
      #http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/
      if args.length == 2
        Image::PhotoUploader.new.send(versions).default_url
      else
        Image::PhotoUploader.new.send(version).send(subversion).default_url
      end
    end
  end

  def fallback_url(size)
    Image::PhotoUploader.new.send(size).default_url
  end

end
