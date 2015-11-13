class AddPositionToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :position, :integer
  end
end
