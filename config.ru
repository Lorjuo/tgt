# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use Rack::Deflater # Gzip Compression: http://stackoverflow.com/questions/11997110/how-to-compress-json-with-gzip-in-rails-for-android
run Rails.application
