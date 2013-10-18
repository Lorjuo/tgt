class AddDescriptionToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :description, :string
  end
end
