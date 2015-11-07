class RenameAnnouncementLink < ActiveRecord::Migration
  def change
    rename_column :announcements, :link, :url
  end
end
