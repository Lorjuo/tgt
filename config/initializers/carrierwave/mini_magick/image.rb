module MiniMagick
  class Image

    def run(command_builder)
      command = command_builder.command

      # CUSTOMIZATION BEGIN
      Rails.logger.debug "MiniMagick Command: #{command}"
      # puts caller if command =~ /mogrify/
      # CUSTOMIZATION END

      sub = Subexec.run(command, :timeout => MiniMagick.timeout)

      if sub.exitstatus != 0
        # Clean up after ourselves in case of an error
        destroy!

        # Raise the appropriate error
        if sub.output =~ /no decode delegate/i || sub.output =~ /did not return an image/i
          raise Invalid, sub.output
        else
          # TODO: should we do something different if the command times out ...?
          # its definitely better for logging.. otherwise we dont really know
          raise Error, "Command (#{command.inspect.gsub("\\", "")}) failed: #{{:status_code => sub.exitstatus, :output => sub.output}.inspect}"
        end
      else
        sub.output
      end
    end
  end
end