class Gallery < ActiveRecord::Base

  # Associations
  has_many :images, :as => :attachable, :class_name => '::Image'

  accepts_nested_attributes_for :images, allow_destroy: true
end
