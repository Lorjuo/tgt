module ElFinder

  # Represents ElFinder connector on Rails side.
  class Connector
    protected

    def _upload
      if perms_for(@current)[:write] == false
        @response[:error] = 'Access Denied'
        return
      end
      select = []
      @params[:upload].to_a.each do |file|
        if file.respond_to?(:tempfile)
          the_file = file.tempfile
        else
          the_file = file
        end
        if upload_max_size_in_bytes > 0 && File.size(the_file.path) > upload_max_size_in_bytes
          @response[:error] ||= "Some files were not uploaded"
          @response[:errorData][@options[:original_filename_method].call(file)] = 'File exceeds the maximum allowed filesize'
        else
          dst = @current + @options[:original_filename_method].call(file)
          the_file.close
          src = the_file.path
          FileUtils.mv(src, dst.fullpath)
          FileUtils.chmod @options[:upload_file_mode], dst
          select << to_hash(dst)

          # CUSTOM
          if(mime_handler.for(dst) =~ /image/)
            image_handler.resize(dst, :width => 800, :height => 600, :to_limit => true)
          end
          # CUSTOM END
        end
      end
      @response[:select] = select unless select.empty?
      _open(@current)
    end # of upload

  end # of class Connector

  class Image

    def self.resize(pathname, options = {})
      return nil unless File.exist?(pathname)
      # CUSTOM
      # TODO: remove exif without losing profile information?:
      # http://stackoverflow.com/questions/13646028/how-to-remove-exif-from-a-jpg-without-losing-image-quality/17516878#17516878
      # http://stackoverflow.com/questions/2654281/how-to-remove-exif-data-without-recompressing-the-jpeg
      #system( ::Shellwords.join(['mogrify', '-resize', "#{options[:width]}x#{options[:height]}"+(options[:to_limit] ? '>' : ''), pathname.to_s]) ) 
      system( ::Shellwords.join(['mogrify', '-strip', '-resize', "#{options[:width]}x#{options[:height]}"+(options[:to_limit] ? '>' : ''), pathname.to_s]) ) 
      # CUSTOM END
    end # of self.resize

  end # of class Image

  # NOTE: Cropping and rotate still does not work
end