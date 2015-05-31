namespace :carrierwave do
  desc "Recreates all thumbs"
  task :recreate => :environment do
    # Image.all.each do |model|
    #   model.file.recreate_versions!
    #   model.save!
    #   # http://stackoverflow.com/questions/7195650/rails-carrierwave-recreate-versions-does-not-change-old-images
    #   puts "Recreated image \##{model.id}"
    # end
    Image.all.each { |old|
      #new_model = Image.new(id: old.id, file: old.file, attachable: old.attachable, attachable_type: old.attachable_type
      #  width: old.width, height: old.height,
      #  file_crop_x: file_crop_x, file_crop_y: file_crop_y, file_crop_w: file_crop_w, file_crop_h: file_crop_h)
      #
      new_model = old.clone
      #new_model.id = old.id
      new_model.file.recreate_versions!
      new_model.save!
      #old.destroy
      puts "Recreating image \##{new_model.id}"
      # TODO: ATM DOES NOT WORK WITH FOG
    }
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