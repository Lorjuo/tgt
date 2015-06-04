class QuickLink < ActiveRecord::Base
    # Associations
  belongs_to :department

  # Validators
  validates :name, :presence => true
  validates :url, :presence => true

  # Scopes
  scope :alphabetical, -> { order("name") }
end
