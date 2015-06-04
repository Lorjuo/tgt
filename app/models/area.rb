# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Area < ActiveRecord::Base

  # Associations
  has_many :departments
end
