class ExternLink < ActiveRecord::Base
  include UrlHelper

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  # http://stackoverflow.com/questions/8774837/what-would-a-default-getter-and-setter-look-like-in-rails
  def url
    url_with_protocol(self[:url])
  end
end
