class CreateHomeCycleSlides < ActiveRecord::Migration
  def change
    create_table :home_cycle_slides do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :position

      t.timestamps null: false
    end
  end
end
