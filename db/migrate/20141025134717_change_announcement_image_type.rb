require 'fileutils'
require 'pathname'

# YOU STILL NEED TO EXECUTE 
# Image::Poster.all.each {|img| img.file.recreate_versions!; img.save!}
# Image.where(:attachable_type => 'trainer').each {|img| img.file.recreate_versions!; img.save!}

# AFTER MIGRATION

class ChangeAnnouncementImageType < ActiveRecord::Migration
  def up
    #Image.all.where(:attachable_type => 'Announcement').each{|image| image.type = 'Image::Poster'; image.save! }
    Image.all.where(:attachable_type => 'Announcement').each do |image|

      old_path = 'public/'+image.file.store_dir
      old_file_path = 'public/'+image.file_url

      # Dir.glob(old_file_path).each do |file|
      #   FileUtils.rm file if file.include? '_'
      # end

      # image.file.recreate_versions!
      # image.save!

      image.type = 'Image::Poster';
      image.save!
      #image.reload # tried to update store_dir but this does not really work
      #new_path = 'public/'+image.file.store_dir
      new_path = old_path.gsub(/\/image\//, '/poster/')

      FileUtils.mkdir_p new_path
      #FileUtils.mv Dir.glob(old_path+'/*'), new_path
      FileUtils.mv Dir.glob(old_file_path), new_path

      # http://stackoverflow.com/questions/8538427/how-to-delete-all-contents-of-a-folder-with-ruby-rails
      FileUtils.rm_rf(Pathname.new(old_path).dirname)

      # http://stackoverflow.com/questions/3686032/how-to-create-directories-recursively-in-ruby
      #FileUtils.mkdir_p new_path
      #Pathname.new(Announcement.first.image.file.store_dir).dirname

    end
    # https://github.com/carrierwaveuploader/carrierwave#recreating-versions
    #Image::Poster.all.each {|img| img.file.recreate_versions!; img.save!}
  end
  def down
    #Image.all.where(:attachable_type => 'Announcement').each{|image| image.type = 'Image'; image.save! }
    Image.all.where(:attachable_type => 'Announcement').each do |image|
      old_path = 'public/'+image.file.store_dir
      new_path = old_path.gsub(/\/poster\//, '/image/')

      FileUtils.mkdir_p new_path
      FileUtils.mv Dir.glob(old_path+'/*'), new_path
      FileUtils.rm_rf(old_path)

      image.type = 'Image';
      image.save!
    end
  end
end