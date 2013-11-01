class Message < ActiveRecord::Base

  # Associations
  belongs_to :department
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true
end
