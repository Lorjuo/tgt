class Location < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode, :if => :geocode?

  # Associations
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  # Function that defines from which data Gmaps4rails will calculate the latitude and longitude
  def gmaps4rails_address    
    address
  end
end
