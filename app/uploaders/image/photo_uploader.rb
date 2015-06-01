# encoding: utf-8
class Image::PhotoUploader < ImageUploader

  process resize_to_limit: [1920, 1920]
  process :store_dimensions
  
  # see: http://carrierwave.rubyforge.org/rdoc/classes/CarrierWave/MiniMagick.html
  # resize_to_limit does not work. But commandline operation works
  # Problem seems to only affect windows version
  
  # version :full do
  #   process resize_to_limit: [960, 960]
  # end

  version :cropped do
    process crop: :file # only crops if parameters crop_x, crop_y, ... are present
    # process crop: [:file, 600, 600] # Resizes the original image to 600x600 limits and then performs cropping
    # performs processing based on full version

    #260x180
    # version :_240x180 do
    #   process resize_to_fill: [240, 180, 'Center']
    # end

    version :thumb do
      process resize_to_fill: [60, 40, 'Center']
    end
  end
  
end
