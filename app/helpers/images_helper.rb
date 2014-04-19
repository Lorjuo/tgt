module ImagesHelper

  #http://stackoverflow.com/questions/10325521/carrierwave-polymorphic-with-default-url-issue
  def image_url(image, size)
    defined?(image.file) ? image.file.url(size) : Image::PhotoUploader.new.send(size).default_url
  end

end
