class ChangeAnnouncementsActiveDefault < ActiveRecord::Migration
  def up
    change_column_default(:announcements, :active, true)
  end

  def down
    change_column_default(:announcements, :active, false)
  end
end
