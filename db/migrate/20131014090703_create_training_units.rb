class CreateTrainingUnits < ActiveRecord::Migration
  def change
    create_table :training_units do |t|
      t.integer :weekday
      t.time :time_begin
      t.time :time_end
      t.integer :location_summer_id
      t.string :location_winter_id

      t.timestamps
    end
  end
end
