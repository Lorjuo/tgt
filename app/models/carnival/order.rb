# == Schema Information
#
# Table name: carnival_orders
#
#  order_id   :integer          not null, primary key
#  person_id  :integer
#  notice     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Carnival::Order < ActiveRecord::Base

  # Associations
  has_many :reservations, :dependent => :destroy
  belongs_to :person, :dependent => :destroy

  accepts_nested_attributes_for :reservations, :allow_destroy => true # To allow destruction via attribute hash
  accepts_nested_attributes_for :person
end
