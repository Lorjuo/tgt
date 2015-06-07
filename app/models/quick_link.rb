# == Schema Information
#
# Table name: quick_links
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  url           :string(255)
#  department_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean          default(TRUE)
#

class QuickLink < ActiveRecord::Base

  include UrlHelper

    # Associations
  belongs_to :department

  # Validators
  validates :name, :presence => true
  validates :url, :presence => true

  # Scopes
  scope :alphabetical, -> { order("name") }

  def get_url
    if self.url.start_with?('/', '#')
      self.url
    else
      url_with_protocol(self.url)
    end
  end
end
