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
end