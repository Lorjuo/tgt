class Placeholder < ActiveRecord::Base

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  def url
    nil
  end
end
