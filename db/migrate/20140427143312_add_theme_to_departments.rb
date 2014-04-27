class AddThemeToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :theme_id, :integer
  end
end
