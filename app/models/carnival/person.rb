class Carnival::Person < ActiveRecord::Base

  # Validations
  validates :email, :presence => true, :email => true
end
