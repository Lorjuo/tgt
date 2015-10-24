class AddColorToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :color, :string
  end
end
