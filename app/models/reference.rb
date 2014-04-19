# == Schema Information
#
# Table name: references
#
#  id                  :integer          not null, primary key
#  reference_to_id     :integer
#  reference_to_type   :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  reference_from_id   :integer
#  reference_from_type :string(255)
#

class Reference < ActiveRecord::Base
  belongs_to :reference_from, :polymorphic => true
  belongs_to :reference_to, :polymorphic => true
end
