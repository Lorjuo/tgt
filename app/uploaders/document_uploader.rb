# encoding: utf-8
class DocumentUploader < BaseUploader
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{partition(model.id)}"
    # "uploads/"\
    # "#{model.attachable.class.to_s.underscore}/"\
    # "#{model.attachable.id.to_s}/"\
    # "#{model.class.to_s.underscore}/"\
    # "#{model.id.to_s}"
  end

  # process :convert => 'png', :if => :image?

  # process :set_content_type, :if => :image?

  version :thumb, :if => :thumbnail? do
    process resize_to_fill: [64, 48]
    process :convert => 'png'
    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  version :_240x240, :if => :thumbnail? do
    process resize_to_fit: [240, 240]
    process :convert => 'png'
    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  version :full, :if => :thumbnail? do
    process resize_to_fit: [800, 800]
    process :convert => 'png'
    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
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

  def cover
    manipulate! do |frame, index|
      # frame if index.zero?
      if index == 0
        frame
      end
    end
  end
  
end
