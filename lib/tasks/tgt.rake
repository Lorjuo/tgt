namespace :tgt do
  require Rails.root + "lib/tasks/importer/importer"
 
  desc "Import old database, usage: rake tgt:import['old_database_name']"
  #rake tgt:import\['old_database_name'\] in zsh
  task :import, [:oldDatabase] => :environment do |t, args|
  #task :import, :oldDatabase, needs::environment do |t, args|
    args.with_defaults(oldDatabase: "import")
 
    oldDatabaseName = args.oldDatabase
    newDatabaseName = YAML::load(IO.read(Rails.root.join("config/database.yml")))[Rails.env]["database"]

    puts "oldDatabase: "+oldDatabaseName
    puts "newDatabase: "+newDatabaseName
 
    importer = Importer.new newDatabaseName, oldDatabaseName

    # Disable Logger
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    importer.execute

    # Reenable logger
    ActiveRecord::Base.logger = old_logger
  end

  # https://github.com/galetahub/ckeditor
  def copy_assets(regexp)
    Rails.application.assets.each_logical_path(regexp) do |name, path|
      asset = Rails.root.join('public', 'assets', name)
      p "Copy #{path} to #{asset}"
      FileUtils.mkdir_p(File.dirname(asset))
      FileUtils.cp path, asset
    end
  end

  desc 'Copy ckeditor assets, that cant be used with digest'
  task copy_nondigest_assets: :environment do
    copy_assets /tinymce/
    copy_assets /elfinder/

    copy_assets /bootstrap\/glyphicons-halflings-regular.woff/
    copy_assets /bootstrap\/glyphicons-halflings-regular.ttf/
    
    copy_assets /blank.gif/
    copy_assets /fancybox_buttons.png/
    copy_assets /fancybox_loading.gif/
    copy_assets /fancybox_loading@2x.gif/
    copy_assets /fancybox_overlay.png/
    copy_assets /fancybox_sprite.png/
    copy_assets /fancybox_sprite@2x.png/
 end
end