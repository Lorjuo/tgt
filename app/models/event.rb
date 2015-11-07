# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  term          :date
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  department_id :integer
#

class Event < ActiveRecord::Base

  include UrlHelper

  # Associations
  belongs_to :department

  # Validators
  validates_date :term
  validates :name, :presence => true
  validates :term, :presence => true

  def get_url
    if self.url.present?
      if self.url.start_with?('/', '#')
        self.url
      else
        url_with_protocol(self.url)
      end
    else
      self.image.file_url
    end
  end

  # Scopes
  scope :chronological, -> { order("term") }
  scope :upcoming, -> { where("term >= ?", Date.today) }
  scope :past, -> { where("term < ?", Date.today) }
  scope :next, -> { upcoming.first }
end
