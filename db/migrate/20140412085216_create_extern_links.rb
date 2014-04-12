class CreateExternLinks < ActiveRecord::Migration
  def change
    create_table :extern_links do |t|
      t.string :url

      t.timestamps
    end
  end
end
