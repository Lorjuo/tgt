namespace :tgt do
  desc "Erase and fill database"
  task :huhu => :environment do
  end
end

# namespace :bla do
#   def copy_assets(regexp)
#     Rails.application.assets.each_logical_path(regexp) do |name, path|
#       asset = Rails.root.join('public', 'assets', name)
#       p "Copy #{path} to #{asset}"
#       FileUtils.mkdir_p(File.dirname(asset))
#       FileUtils.cp path, asset
#     end
#   end

#   desc 'Copy ckeditor assets, that cant be used with digest'
#   task copy_nondigest_assets: :environment do
#     copy_assets /tinymce/
#   end
# end