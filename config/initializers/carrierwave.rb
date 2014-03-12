# https://gist.github.com/AndreyChernyh/1058477
#
# Yield Blocks do not work:
# http://stackoverflow.com/questions/19646083/carrierwave-how-to-pass-block-to-resize-and-pad
module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
    def resize_to_limit(width, height, format="")
      manipulate! do |img|
        img.resize "#{width}x#{height}>"
        # CUSTOMIZATION BEGIN
        img.format(format) if format.present?
        # CUSTOMIZATION END
        img = yield(img) if block_given?
        img
      end
    end

    def resize_to_fit(width, height, format="")
      manipulate! do |img|
        img.resize "#{width}x#{height}"
        # CUSTOMIZATION BEGIN
        img.format(format) if format.present?
        # CUSTOMIZATION END
        img = yield(img) if block_given?
        img
      end
    end

    def resize_to_fill(width, height, gravity = 'Center', format="")
      manipulate! do |img|
        cols, rows = img[:dimensions]
        img.combine_options do |cmd|
          if width != cols || height != rows
            scale_x = width/cols.to_f
            scale_y = height/rows.to_f
            if scale_x >= scale_y
              cols = (scale_x * (cols + 0.5)).round
              rows = (scale_x * (rows + 0.5)).round
              cmd.resize "#{cols}"
            else
              cols = (scale_y * (cols + 0.5)).round
              rows = (scale_y * (rows + 0.5)).round
              cmd.resize "x#{rows}"
            end
          end
          cmd.gravity gravity
          cmd.background "rgba(255,255,255,0.0)"
          cmd.extent "#{width}x#{height}" if cols != width || rows != height
        end
        # CUSTOMIZATION BEGIN
        img.format(format) if format.present?
        # CUSTOMIZATION END
        img = yield(img) if block_given?
        img
      end
    end

    def resize_and_pad(width, height, background=:transparent, gravity='Center', format="")
      manipulate! do |img|
        img.combine_options do |cmd|
          cmd.thumbnail "#{width}x#{height}>"
          if background == :transparent
            cmd.background "rgba(255, 255, 255, 0.0)"
          else
            cmd.background background
          end
          cmd.gravity gravity
          cmd.extent "#{width}x#{height}"
        end
        # CUSTOMIZATION BEGIN
        img.format(format) if format.present?
        # CUSTOMIZATION END
        img = yield(img) if block_given?
        img
      end
    end
  end
end

