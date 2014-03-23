module StringHelper
  # http://makandracards.com/makandra/1309-sanitize-filename-with-user-input
  # http://stackoverflow.com/questions/1939333/how-to-make-a-ruby-string-safe-for-a-filesystem
  # http://stackoverflow.com/questions/6887319/common-method-in-model-and-helper
  # http://stackoverflow.com/questions/14144702/where-to-put-helper-methods-needed-in-multiple-models-in-a-rails-app
  # http://stackoverflow.com/questions/5160780/what-does-def-self-includedbase-do-in-ruby-on-railss-restful-authentication
  def sanitize_filename(filename)
    filename.gsub(/[^0-9A-z.\-]/, ' ')
  end
end