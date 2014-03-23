class Announcement < ActiveRecord::Base

  # TODO: Maybe replace anouncements freetext html with images

  # Scopes
  scope :active, -> { where(:active => true) }
  scope :visible, -> {
    where("visible_from IS NULL OR visible_from <= ?", Date.today)
    .where("visible_to IS NULL OR visible_to >= ?", Date.today)
  }

  # Validations
  validates :name, :presence => true
  validates_date :visible_from, :allow_blank => true
  validates_date :visible_to, :allow_blank => true, :after => :visible_from
end
