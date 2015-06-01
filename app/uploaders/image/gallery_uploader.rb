# encoding: utf-8
# Cannot inherit directly from a class that specifies versions, because these versions will be stored inside the directory declared in parent class via store_dir
#class Image::GalleryUploader < Image::PhotoUploader
class Image::GalleryUploader < Image::ImageUploader

  def store_dir
    "uploads/"\
    "#{model.attachable.class.to_s.underscore}/"\
    "#{model.attachable.id.to_s}/"\
    "#{model.id.to_s}"
    #{}"#{model.class.to_s.demodulize.underscore}/"\
    #{}"#{model.id.to_s}"
    # demodulize: strip namespace
  end

  process resize_to_fit: [800, 600]
  process :store_dimensions

  version :thumb do
    process resize_to_fill: [64, 48]
  end
  version :_260x180 do
    process resize_to_fill: [260, 180]
  end
  version :_300x200 do
    process resize_to_fill: [300, 200]
  end
  
end
