# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  address     :string(255)
#  latitude    :float
#  longitude   :float
#  gmaps       :boolean
#  description :text
#

class Location < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode, :if => :geocode?

  # Associations
  has_one :image, :as => :attachable, :class_name => 'Image::Image', :dependent => :destroy
  has_many :training_units_summer, class_name: "TrainingUnit", foreign_key: "location_summer_id"
  has_many :training_units_winter, class_name: "TrainingUnit", foreign_key: "location_winter_id"

  accepts_nested_attributes_for :image, allow_destroy: true

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  # Function that defines from which data Gmaps4rails will calculate the latitude and longitude
  def gmaps4rails_address    
    address
  end
end
