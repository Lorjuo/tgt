# == Schema Information
#
# Table name: carnival_reservations
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  session_id  :integer
#  category_id :integer
#  amount      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Carnival::Reservation < ActiveRecord::Base

  # Associations
  belongs_to :session
  belongs_to :category

  # Validations
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }
end
