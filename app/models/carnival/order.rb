class Carnival::Order < ActiveRecord::Base

  # Associations
  has_many :reservations, :dependent => :destroy
  belongs_to :person, :dependent => :destroy

  accepts_nested_attributes_for :reservations, :allow_destroy => true # To allow destruction via attribute hash
  accepts_nested_attributes_for :person
end
