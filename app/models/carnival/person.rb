class Carnival::Person < ActiveRecord::Base

  # Validations
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :street, :presence => true
  validates :zip, :presence => true
  validates :city, :presence => true
  validates :email, :presence => true, :email => true
end
