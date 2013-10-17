# encoding: utf-8
class ImageUploader < BaseImageUploader
  process :set_content_type

  def store_dir
    "uploads/"\
    "#{model.imageable.class.to_s.underscore}/"\
    "#{model.imageable.id.to_s}/"\
    "#{model.class.to_s.underscore}/"\
    "#{model.id.to_s}"
  end

  # see: http://carrierwave.rubyforge.org/rdoc/classes/CarrierWave/MiniMagick.html
  # resize_to_limit does not work. But commandline operation works

  version :thumb do
    process resize_to_fit: [64, 64]
  end
  version :small do
    process resize_to_fit: [100, 100]
  end
  version :medium do
    process resize_to_fit: [240, 240]
  end
  # version :main do
  #   process resize_to_fit: [300, 300]
  # end
  version :large do
    process resize_to_fit: [400, 400]
  end
  # version :full do
  #   process resize_to_fit: [600, 600]
  # end
  version :_260x180 do
    process resize_to_fill: [260, 180]
  end
  version :_200x300 do
    process resize_to_fill: [300, 200]
  end
  
end