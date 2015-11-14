#require 'mini_magick'

MiniMagick.configure do |config|
  #config.debug = true
  config.cli = :graphicsmagick
end