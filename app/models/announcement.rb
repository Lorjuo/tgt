class Announcement < ActiveRecord::Base

  # Scopes
  scope :active, -> {where(:active => true)}
end
