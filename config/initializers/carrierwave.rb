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

  #   def manipulate!(options={})
  #     cache_stored_file! if !cached?
  #     if options[:page]
  #       image = ::MiniMagick::Image.open(current_path+"[#{options[:page]}]")
  #     else
  #       image = ::MiniMagick::Image.open(current_path)
  #     end
  #     image.format(@format.to_s.downcase) if @format
  #     image = yield(image)
  #     image.write(current_path)
  #     ::MiniMagick::Image.open(current_path)
  #   rescue ::MiniMagick::Error, ::MiniMagick::Invalid => e
  #     raise CarrierWave::ProcessingError, I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :default => I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :locale => :en))
  #   end
  end
end

