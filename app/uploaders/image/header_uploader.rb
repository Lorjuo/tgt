# encoding: utf-8
class Image::HeaderUploader < ImageUploader

  #process resize_to_fit: [800, 600]
  process resize_to_limit: [1920, 1920]
  process :store_dimensions
  
  # version :full do
  #   process resize_to_limit: [960, 960]
  # end

  version :cropped do
    # To crop this version based on `jumbo` version, pass width = 600 and height = 600
    # Specify both width and height values otherwise they would be ignored
    process crop: :file
    # process crop: [:file, 600, 600] # Resizes the original image to 600x600 and then performs cropping 
    # resize_to_limit(600,150)

    # version :_240x60 do
    #   process resize_to_fill: [240, 60, 'Center']
    # end
  end

end