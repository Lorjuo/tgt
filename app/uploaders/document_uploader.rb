# encoding: utf-8
class DocumentUploader < BaseUploader
  include CarrierWave::MiniMagick
  #include CarrierWave::RMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{partition(model.id)}"
    # "uploads/"\
    # "#{model.attachable.class.to_s.underscore}/"\
    # "#{model.attachable.id.to_s}/"\
    # "#{model.class.to_s.underscore}/"\
    # "#{model.id.to_s}"
  end

  # Move files instead of copying for better performance
  def move_to_cache
    true
  end
  def move_to_store
    true
  end

  # process :convert => 'jpg', :if => :image?

  # process :set_content_type, :if => :image?
  
  # version :image, :if => :thumbnail? do

  #   process :extract_first_page

  #   process resize_to_fill: [64, 48]

  #   def full_filename (for_file = model.source.file)
  #     super.chomp(File.extname(super)) + '.jpg'
  #   end
  
  # end

  # version :thumb, :if => :thumbnail? do

  #   process :mogrify => [{
  #     :resolution => '108x369'
  #   }]
  # end

  version :image, :if => :thumbnail? do
    # process :extract_first_page
    # process :create_thumb
    # process :cover
    # process :convert => 'jpg'
    # process resize_to_fill: [64, 48]
    process :mogrify => [{
      :resolution => '800x800'
    }]
    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  # version :full, :if => :thumbnail? do
  #   process :convert => 'jpg'
  #   process resize_to_fit: [800, 800]
  #   def full_filename (for_file = model.source.file)
  #     super.chomp(File.extname(super)) + '.jpg'
  #   end
  # end

  # version :_240x240, :if => :thumbnail? do
  #   process :extract_first_page
  #   process resize_to_fit: [240, 240]
  #   # process :convert => 'jpg'
  #   def full_filename (for_file = model.source.file)
  #     super.chomp(File.extname(super)) + '.jpg'
  #   end
  # end

  # version :full, :if => :thumbnail? do
  #   process :extract_first_page
  #   process resize_to_fit: [800, 800]
  #   # process :convert => 'jpg'
  #   def full_filename (for_file = model.source.file)
  #     super.chomp(File.extname(super)) + '.jpg'
  #   end
  # end

  # https://github.com/carrierwaveuploader/carrierwave/pull/691
  def cover
    manipulate! do |frame, index|
      #frame if index.zero?
      if index == 0
        frame
      end
    end
  end

  # def cover
  #   format = 'png'
  #   manipulate!(:format => format) do |frame, index|
  #     #frame if index.zero?
  #     if index == 0
  #       frame.resize_to_fit!(64, 48)
  #       frame = yield(frame) if block_given?
  #       frame
  #     end
  #   end
  #   @format = format
  # end

  def check
    Rails.logger.debug 'Check'
  end

  def custom_cover
    manipulate! do |img|
      Rails.logger.debug 'Check'

      path = img.path

      #new_tmp_path = File.join(Rails.root, 'public', cache_dir, "/cover_#{File.basename(path)}")
      new_tmp_path = File.join(Rails.root, 'public', cache_dir, "/cover.jpg")

      # width, height = img[:dimensions]

      # radius_point = ((width > height) ? [width / 2, height] : [width, height / 2]).join(',')

      # imagemagick_command = ['convert',
      #                      "-size #{ width }x#{ height }",
      #                      'xc:transparent',
      #                      "-fill #{ path }",
      #                      "-draw 'circle #{ width / 2 },#{ height / 2 } #{ radius_point }'",
      #                      "+repage #{new_tmp_path}"].join(' ')
                           
      imagemagick_command = "convert #{path}[0] -quality 80 -resize 600x800 #{new_tmp_path}"

      system(imagemagick_command)
      MiniMagick::Image.open(new_tmp_path)

      image = ::MiniMagick::Image.from_file(current_path)
      image = yield(image)
      image.write(current_path)
    end
  end

  # http://stackoverflow.com/questions/13202992/carrierwave-with-custom-processor-not-registering
  def create_thumb(site = '600x800', quality = '80')
    cached_stored_file! if !cached?

    #movie = FFMPEG::Movie.new(current_path)

    dirname = File.dirname(current_path)

    temp_path = "#{File.join(dirname, File.basename(current_path, File.extname(current_path)))}.jpg"

    #movie.screenshot(temp_path, :seek_time => 5)
    # http://stackoverflow.com/questions/4809314/imagemagick-is-converting-only-the-first-page-of-the-pdf
    # http://www.imagemagick.org/script/command-line-options.php
    imagemagick_command = "convert #{current_path}[0] -quality #{quality} -resize #{size} #{temp_path}"
    # http://rubyquicktips.com/post/5862861056/execute-shell-commands
    # system(imagemagick_command)
    Rails.logger.debug imagemagick_command + `time #{imagemagick_command}`

    File.rename temp_path, current_path
  end



  # http://stackoverflow.com/questions/653380/converting-a-pdf-to-png
  def extract_first_page
    # NOTE: path and current_path exists but for different versions
    cached_stored_file! if !cached?

    debugger

    dirname = File.dirname(current_path)

    temp_path = "#{File.join(dirname, File.basename(current_path, File.extname(current_path)))}.jpg"
    imagemagick_command = "convert #{current_path}[0] #{temp_path}"
    # system(imagemagick_command)
    Rails.logger.warn imagemagick_command + `time #{imagemagick_command}`


    #File.rename temp_path, path
    # old_path = path
    # path = temp_path
    # File.unlink old_path

    #File.rename temp_path, path

    # File.unlink(current_path)
    # FileUtils.mv(temp_path, current_path)
    
    # file = CarrierWave::SanitizedFile.new(temp_path)
    ::MiniMagick::Image.open(temp_path)

  end

  def mogrify(options = {})
    manipulate! do |img|
      img.format("jpg") do |c|
        #c.fuzz        "3%"
        #c.trim
        #c.rotate      "#{options[:rotate]}" if options.has_key?(:rotate)
        c.resize      "#{options[:resolution]}>" if options.has_key?(:resolution)
        c.resize      "#{options[:resolution]}<" if options.has_key?(:resolution)
        #c.push        '+profile'
        #c.+           "!xmp,*"
        #c.profile     "#{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
        #c.colorspace  "sRGB"
      end
      img
    end
  end


protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def thumbnail?(new_file)
    %w(jpg jpeg gif pdf png tiff).include?(new_file.extension)
  end

  def pdf?(new_file)
    %w(pdf).include?(new_file.extension)
  end
  
end
