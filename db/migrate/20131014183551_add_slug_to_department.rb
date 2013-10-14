class AddSlugToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :slug, :string
    add_index :departments, :slug, unique: true
  end
end
