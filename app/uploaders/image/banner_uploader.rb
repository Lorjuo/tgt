# encoding: utf-8
class Image::BannerUploader < Image::BaseImageUploader

  version :cropped do
    # To crop this version based on `jumbo` version, pass width = 600 and height = 600
    # Specify both width and height values otherwise they would be ignored
    process crop: :file
    # process crop: [:file, 600, 600] # Resizes the original image to 600x600 and then performs cropping 
    #resize_to_limit(600,150)
  end
  version :thumb do
    process resize_to_fill: [64, 48]
  end

  def store_dir # REMOVE THIS LATER
    #parent_id = model.tmp_parent_id ? model.tmp_parent_id : model.attachable.id
    "uploads/"\
    "#{model.class.to_s.demodulize.underscore}/"\
    "#{model.id.to_s}"
    # demodulize: strip namespace
  end

end