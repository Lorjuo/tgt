class AddAreaIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :area_id, :integer
  end
end
