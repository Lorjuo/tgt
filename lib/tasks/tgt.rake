namespace :tgt do
  require Rails.root + "lib/tasks/importer/importer"
 
  desc "Import old database, usage: rake tgt:import['old_database_name']"
  #bundle exec rake db:reset RAILS_ENV=production
  #bundle exec rake tgt:import['tgt_old'] RAILS_ENV=production as deploy user on production environment
  #rake tgt:import\['old_database_name'\] in zsh
  task :import, [:oldDatabase] => :environment do |t, args|
  #task :import, :oldDatabase, needs::environment do |t, args|
    args.with_defaults(oldDatabase: "import")
 
    oldDatabaseName = args.oldDatabase
    newDatabaseName = YAML::load(IO.read(Rails.root.join("config/database.yml")))[Rails.env]["database"]

    puts "oldDatabase: "+oldDatabaseName
    puts "newDatabase: "+newDatabaseName
 
    importer = Importer.new newDatabaseName, oldDatabaseName

    # Disable Logger - Disable SQL logging
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
    #copy_assets /tinymce\/langs/
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

    copy_assets /alpha.png/
    copy_assets /hue.png/
    copy_assets /saturation.png/
  end

  desc 'Remove all images that are not associated to any attachable'
  # These may be images created with jquery popup uploader but not attached to an object
  task :remove_unused_images => :environment do
    puts "RAKE_TASK: remove_unused_images"
    Image.where({:attachable_id => nil})
    .where("created_at < :hour", {:hour => 1.hour.ago}).each do |img|
      puts "Deleting image #{img.name} in #{img.file.store_dir}"
      img.destroy
      # http://stackoverflow.com/a/4177714/871495
    end
    puts "#{Time.now} - Success!"
  end

  desc 'Regenerate all already defined slugs'
  # see: https://github.com/norman/friendly_id
  # rake tgt:regenerate_slugs RAILS_ENV=production 
  task :regenerate_slugs => :environment do
    Department.all.each do |entity|
      entity.slug = nil
      entity.save!
      puts "Regenerating slug '#{entity.slug}' for entity '#{entity.name}'"
    end
    Trainer.all.each do |entity|
      entity.slug = nil
      entity.save!
      puts "Regenerating slug '#{entity.slug}' for entity '#{entity.name}'"
    end
  end

  desc "Recreates directory structure for all departments"
  # rake tgt:create_directory_structure RAILS_ENV=production 
  task :create_directory_structure => :environment do
    Department.all.each do |entity|
      entity.create_directory_structure
    end
  end

  desc "Recreates navigation structure for all departments"
  # rake tgt:create_navigation_structure RAILS_ENV=production 
  task :create_navigation_structure => :environment do
    Department.all.each do |entity|
      entity.create_navigation_structure unless entity.name == 'generic' 
    end
  end
end