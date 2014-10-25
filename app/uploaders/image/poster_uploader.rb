# encoding: utf-8
class Image::PosterUploader < ImageUploader

  process resize_to_fit: [800, 600]
  
  # see: http://carrierwave.rubyforge.org/rdoc/classes/CarrierWave/MiniMagick.html
  # resize_to_limit does not work. But commandline operation works
  # Problem seems to only affect windows version

  version :thumb do
    #process resize_to_fit: [64, 64]
    process resize_to_fill: [64, 48]
  end
  version :_300x300 do
    process resize_to_fit: [300, 300, 'North']
  end
  
end
 