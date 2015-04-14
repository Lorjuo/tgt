class Asset < ActiveRecord::Base
  
  # Either use abstract class for this
  # or extract this functionality to a module that will be then included by Image::Base, Video::Base, ...
  # http://stackoverflow.com/questions/3532985/rails-activerecord-inheriting-from-a-base-class-with-no-table
  self.abstract_class = true


  # Filters
  before_create :default_name
  before_update :default_name

  after_destroy :clear_directory


  # Scopes
  scope :chronological, -> { order("created_at" => :desc) }


  # Methods
  def default_name
    debugger
    # file.filename replaced by file.original_file
    if(self.name.blank? && self.file.present?)
      self.name = File.basename(file.original_file, '.*').titleize if file
    end
  end

  def clear_directory # Maybe this method will work only in subclasses with mounted uploader
    store_dir = file.store_dir
    remove_file! # Remove the file object
    FileUtils.remove_dir("#{Rails.root}/public/#{store_dir}", :force => true)
  end
end