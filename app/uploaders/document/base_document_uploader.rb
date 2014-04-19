# encoding: utf-8
class Document::BaseDocumentUploader < BaseUploader
  include CarrierWave::MiniMagick
  #include CarrierWave::RMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{partition(model.id)}"
    # "uploads/#{model.class.to_s.underscore}/#{model.id}"
    # "uploads/"\
    # "#{model.attachable.class.to_s.underscore}/"\
    # "#{model.attachable.id.to_s}/"\
    # "#{model.class.to_s.underscore}/"\
    # "#{model.id.to_s}"
  end

  # partitions ID to be like: 0000/0000/0123
  # to keep no more than 10,000 entries per directory
  # EXT3 max: 32,000 dirs
  # EXT4 max: 64,000 dirs
  def partition(modelid)
    ("%08d" % modelid).scan(/\d{4}/).join("/")
    # ("%012d" % modelid).scan(/\d{4}/).join("/")
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

  version :cover, :if => :thumbnail? do
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

    version :thumb do
      process resize_to_fill: [64, 48, 'Center', 'jpg'] do |img|
        img.format('jpg')
        img
      end
    end

    version :_80x80 do
      process resize_to_fill: [80, 80, 'Center', 'jpg'] do |img|
        img.format('jpg')
        img
      end
    end

    version :_240x240 do
      process resize_to_fit: [240, 240, 'jpg']
      # Yield Blocks do not work: http://stackoverflow.com/questions/19646083/carrierwave-how-to-pass-block-to-resize-and-pad
      # process resize_to_fit: [240, 240] do |img|
      #   img.format('jpg')
      #   img
      # end
      # process :resize_and_pad => [1200, 1200, 'white'] { |img| do_everything_else.call img }
      # process :resize_to_fit => [240, 240] { |img| img.format('jpg'); img }
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
  # def cover
  #   manipulate! do |frame, index|
  #     #frame if index.zero?
  #     if index == 0
  #       frame
  #     end
  #   end
  # end

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
    format = 'jpg'
    @format = format
    # manipulate! do |img|
    #   # img.format        format.to_s.downcase
    #   # img.combine_options do |cmd|
    #   #   cmd.profile     "#{Rails.root}/lib/color_profiles/USWebCoatedSWOP.icc"
    #   #   cmd.resize      "#{options[:resolution]}>" if options.has_key?(:resolution)
    #   #   cmd.resize      "#{options[:resolution]}<" if options.has_key?(:resolution)
    #   #   cmd.colorspace  "sRGB"
    #   #   cmd.profile     "#{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
    #   # end
    #   # img.format(format.to_s.downcase) do |c|
    #   #   c.profile     "#{Rails.root}/lib/color_profiles/USWebCoatedSWOP.icc"
    #   #   #c.fuzz        "3%"
    #   #   #c.trim
    #   #   #c.rotate      "#{options[:rotate]}" if options.has_key?(:rotate)
    #   #   c.resize      "#{options[:resolution]}>" if options.has_key?(:resolution)
    #   #   c.resize      "#{options[:resolution]}<" if options.has_key?(:resolution)
    #   #   #c.push        '+profile'
    #   #   #c.+           "!xmp,*"
    #   #   c.colorspace  "sRGB"
    #   #   c.profile     "#{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
        
    #   #   #c.quality     100
    #   #   #c.depth       16
    #   #   #c.profile     'sRGB.icc'
    #   # end
    #   img
    # end
    dirname = File.dirname(current_path)
    jpg_path = "#{File.join(dirname, File.basename(current_path, File.extname(current_path)))}.jpg"

    # Maybe strip command at beginning to strip existing profiles

    # http://www.imagemagick.org/discourse-server/viewtopic.php?t=18514
    imagemagick_command = "mogrify"\
    " -filter lanczos2sharp"\
    " -antialias"\
    " -profile #{Rails.root}/lib/color_profiles/USWebCoatedSWOP.icc"\
    " -profile #{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"\
    " -colorspace sRGB"\
    " -format jpg -resize 800x800\\> -distort resize 800x800\\< -quality 80"\
    " #{current_path}\\[0\\]"
    system(imagemagick_command)
    File.unlink current_path
    File.rename jpg_path, current_path
    Rails.logger.warn imagemagick_command #+ `time #{imagemagick_command}`
    #::MiniMagick::Image.open(current_path)
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
