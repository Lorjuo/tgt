# == Schema Information
#
# Table name: images
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  file            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string(255)
#  type            :string(255)
#

class Image < ActiveRecord::Base

  # Note: Alternative approach:
  # http://rails-bestpractices.com/posts/45-use-sti-and-polymorphic-model-for-multiple-uploads
  # https://coderwall.com/p/g4lkbq
  # http://stackoverflow.com/questions/849897/can-rails-migrations-be-used-to-convert-data
  # http://makandracards.com/makandra/15575-how-to-write-complex-migrations-in-rails
  # 
  # Image STI and polymorphic associations
  # http://rails-bestpractices.com/posts/45-use-sti-and-polymorphic-model-for-multiple-uploads
  # For Paperclip:
  # http://www.jotlab.com/2012/uploading-with-rails-3-1-carrierwave-mediainfo-single-table-inheritance-and-polymorphism
  # 
  # Jquery Fileuploader jcrop integration via callback
  # https://github.com/blueimp/jQuery-File-Upload/issues/1314
  # 
  # Railscasts crop
  # http://stackoverflow.com/questions/21027034/rails-carrierwave-jcrop-bootstrap
  # https://github.com/railscasts/182-cropping-images-revised/blob/master/cropper-after/
  # http://stackoverflow.com/questions/21027034/rails-carrierwave-jcrop-bootstrap
  # Live preview:
  # http://runnable.com/UmsiPSpmP8lBAAAZ/cropping-images-with-carrierwave-for-ruby-on-rails-and-jcrop
  # 
  # Aspect Ratio
  # http://www.rqna.net/qna/pnyiuq-carrierwave-dynamic-height-width-and-cropping.html
  # 
  # Dynamic store dir and friendly id
  # http://stackoverflow.com/questions/8773798/dynamic-store-dir-with-carrierwave
  # 
  # Carrierwave crop gem
  # https://github.com/kirtithorat/carrierwave-crop
  # 
  # HTML 5 Image uploader with Jcrop (Preview on client side)
  # http://www.script-tutorials.com/html5-image-uploader-with-jcrop/

  # Associations
  belongs_to :attachable, polymorphic: true

  # Uploader
  mount_uploader :file, ::Image::PhotoUploader, :mount_on => :file
  crop_uploaded :file

  before_create :default_name
  before_update :default_name

  after_destroy :clear_directory

  #attr_accessor :tmp_parent_id

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
