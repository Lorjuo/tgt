namespace :carrierwave do
  desc "Recreates all thumbs"
  task :recreate => :environment do
    Image.all.each do |model|
      model.file.recreate_versions!
      model.save!
      puts "Recreated image \##{model.id}"
    end
  end

  task :destroy => :environment do
    desc "Destroys all images"
    Image.all.each do |model|
      id = model.id
      model.destroy!
      puts "Destroy image \##{id}"
    end
  end
end