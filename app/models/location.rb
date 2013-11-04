class Location < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode#, :if => :geocode?

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  # Function that defines from which data Gmaps4rails will calculate the latitude and longitude
  def gmaps4rails_address    
    address
  end
end
