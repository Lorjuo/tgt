# encoding: utf-8
class Image::BannerUploader < ImageUploader

  process resize_to_fit: [1600, 1200]

  version :cropped do
    # To crop this version based on `jumbo` version, pass width = 600 and height = 600
    # Specify both width and height values otherwise they would be ignored
    process crop: :file
    # process crop: [:file, 600, 600] # Resizes the original image to 600x600 and then performs cropping 
    # resize_to_limit(600,150)
  end

end