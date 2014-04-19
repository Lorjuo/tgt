# == Schema Information
#
# Table name: placeholders
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Placeholder < ActiveRecord::Base
  include Linkable

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  def url
    nil
  end
end
