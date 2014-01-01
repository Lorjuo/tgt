module MiniMagick
  class Image

    def composite(other_image, output_extension = 'jpg', &block)
      begin
        second_tempfile = Tempfile.new(output_extension)
        second_tempfile.binmode
      ensure
        second_tempfile.close
      end

      command = CommandBuilder.new("composite")
      block.call(command) if block
      command.push(other_image.path)
      # CUSTOMIZATION BEGIN
      extension = File.extname(self.path)
      if(extension == '.pdf')
        command.push(self.path+"[#{self.path}]")
      else
        command.push(self.path)
      end
      # CUSTOMIZATION END
      command.push(second_tempfile.path)

      run(command)
      return Image.new(second_tempfile.path, second_tempfile)
    end
  end
end
