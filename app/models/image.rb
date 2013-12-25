class Image < ActiveRecord::Base

  # Note: Alternative approach:
  # http://rails-bestpractices.com/posts/45-use-sti-and-polymorphic-model-for-multiple-uploads
  # https://coderwall.com/p/g4lkbq
  # http://stackoverflow.com/questions/849897/can-rails-migrations-be-used-to-convert-data
  # http://makandracards.com/makandra/15575-how-to-write-complex-migrations-in-rails

  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ImageUploader, :mount_on => :file

  before_create :default_name
  before_update :default_name

  after_destroy :clear_directory

  attr_accessor :tmp_parent_id

  def default_name
    # file.filename replaced by file.original_file
    if(self.name.blank?)
      self.name = File.basename(file.original_file, '.*').titleize if file
    end
  end

  def self.image_list
    all.map{ |im| [im.name, im.file.url] }
  end

  def clear_directory
    store_dir = file.store_dir
    remove_file!
    FileUtils.remove_dir("#{Rails.root}/public/#{store_dir}", :force => true)
  
    # Save (only empty directories)
    #Dir.rmdir
  end
end
