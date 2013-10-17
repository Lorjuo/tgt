class Image < ActiveRecord::Base

  # Associations
  belongs_to :imageable, polymorphic: true

  # Uploader
  mount_uploader :file, ImageUploader, :mount_on => :file

  before_create :default_name
  before_update :default_name

  def default_name
    # file.filename replaced by file.original_file
    if(self.name.blank?)
      self.name = File.basename(file.original_file, '.*').titleize if file
    end
  end

  def self.image_list
    all.map{ |im| [im.name, im.file.url] }
  end
end
