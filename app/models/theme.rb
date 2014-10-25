# == Schema Information
#
# Table name: themes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  color       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Theme < ActiveRecord::Base

  # Associations
  has_one :banner, :as => :attachable, :class_name => 'Image::Banner', :dependent => :destroy

  accepts_nested_attributes_for :banner, allow_destroy: true

  # Validations
  validates :name, :presence => true
  validates :color, :presence => true
end
