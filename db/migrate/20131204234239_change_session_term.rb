class ChangeSessionTerm < ActiveRecord::Migration
  def up
    change_column :carnival_sessions, :term, :datetime
  end
  def down
    change_column :carnival_sessions, :term, :date
  end
end
