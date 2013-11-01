class Gallery < ActiveRecord::Base

  # Associations
  has_many :images, :as => :attachable, :class_name => '::Image'
  belongs_to :preview_image, :class_name => '::Image'

  accepts_nested_attributes_for :images, allow_destroy: true

  def get_preview_image
    self.preview_image || self.images.first
  end
end
