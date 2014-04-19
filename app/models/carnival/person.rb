# == Schema Information
#
# Table name: carnival_people
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  street     :string(255)
#  zip        :string(255)
#  city       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Carnival::Person < ActiveRecord::Base

  # Validations
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :street, :presence => true
  validates :zip, :presence => true
  validates :city, :presence => true
  validates :email, :presence => true, :email => true
end
