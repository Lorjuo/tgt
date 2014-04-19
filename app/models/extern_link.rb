# == Schema Information
#
# Table name: extern_links
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ExternLink < ActiveRecord::Base
  include UrlHelper
  include Linkable

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  # Validations
  validates :url, :presence => true

  # http://stackoverflow.com/questions/8774837/what-would-a-default-getter-and-setter-look-like-in-rails
  def url
    url_with_protocol(self[:url])
  end
end
