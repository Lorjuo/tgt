class CreateCarnivalCategories < ActiveRecord::Migration
  def change
    create_table :carnival_categories do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
