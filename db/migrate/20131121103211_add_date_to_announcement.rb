class AddDateToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :visible_from, :date
    add_column :announcements, :visible_to, :date
  end
end
