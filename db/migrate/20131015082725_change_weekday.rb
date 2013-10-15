class ChangeWeekday < ActiveRecord::Migration
  def change
    rename_column :training_units, :weekday, :week_day
  end
end
