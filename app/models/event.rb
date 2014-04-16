class Event < ActiveRecord::Base

  # Associations
  belongs_to :department

  # Validators
  validates_date :term
  validates :name, :presence => true
  validates :term, :presence => true

  # Scopes
  scope :chronological, -> { order("term") }
  scope :upcoming, -> { where("term >= ?", Date.today) }
  scope :past, -> { where("term < ?", Date.today) }
  scope :next, -> { upcoming.first }
end
