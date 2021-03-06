# encoding: utf-8
# Cannot inherit directly from a class that specifies versions, because these versions will be stored inside the directory declared in parent class via store_dir
#class Image::GalleryUploader < Image::PhotoUploader
class Image::GalleryUploader < ImageUploader

  def store_dir
    "uploads/"\
    "#{model.attachable.class.to_s.underscore}/"\
    "#{model.attachable.id.to_s}/"\
    "#{model.id.to_s}"
    #{}"#{model.class.to_s.demodulize.underscore}/"\
    #{}"#{model.id.to_s}"
    # demodulize: strip namespace
  end

  process resize_to_fit: [1200, 900]
  process :store_dimensions

  version :preview do
    process resize_to_fill: [300, 200]
  end

  version :miniature do
    process resize_to_fill: [168, 112]
  end

  version :thumb do
    process resize_to_fill: [60, 40]
  end
  
end
