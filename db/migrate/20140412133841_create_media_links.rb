class CreateMediaLinks < ActiveRecord::Migration
  def change
    create_table :media_links do |t|
      t.string :controller_id
      t.integer :instance_id

      t.timestamps
    end
  end
end
