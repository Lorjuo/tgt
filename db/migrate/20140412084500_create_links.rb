class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :department_id
      
      t.integer :linkable_id
      t.string :linkable_type

      t.timestamps
    end
    add_index :links, [:linkable_id, :linkable_type]
  end
end
