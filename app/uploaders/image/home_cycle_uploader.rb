# encoding: utf-8
class Image::HomeCycleUploader < ImageUploader

  process resize_to_limit: [1920, 1920]
  process :store_dimensions

  version :cropped do
    process crop: :file
    process resize_to_fill: [1200, 400]

    version :_600x200 do
      process resize_to_fill: [600, 200, 'Center']
    end
  end

end