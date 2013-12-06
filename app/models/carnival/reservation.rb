class Carnival::Reservation < ActiveRecord::Base

  # Associations
  belongs_to :session
  belongs_to :category

  # Validations
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }
end
