# encoding: utf-8
class Image::BannerUploader < ImageUploader

  process resize_to_fit: [1920, 1600]
  process :store_dimensions

  version :cropped do
    # To crop this version based on `jumbo` version, pass width = 600 and height = 600
    # Specify both width and height values otherwise they would be ignored
    process crop: :file
    process resize_to_limit: [600, 100]
    # process crop: [:file, 600, 600] # Resizes the original image to 600x600 and then performs cropping 
    # resize_to_limit(600,150)
  end

  def default_url
    if version_name == :cropped
      ActionController::Base.helpers.asset_path("fallback/cropped__600x100_default.png")
    else
      super
    end
  end

end