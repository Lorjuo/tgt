class ChangeLocationWinter < ActiveRecord::Migration
  def change
    change_column :training_units, :location_winter_id, :integer
  end
end
