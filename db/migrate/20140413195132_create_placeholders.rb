class CreatePlaceholders < ActiveRecord::Migration
  def change
    create_table :placeholders do |t|

      t.timestamps
    end
  end
end
