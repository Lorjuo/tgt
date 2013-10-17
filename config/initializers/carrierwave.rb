#https://gist.github.com/AndreyChernyh/1058477
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage)
        img = yield(img) if block_given?
        img
      end
    end
  end
end