class AddDepartmentIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :department_id, :integer
  end
end
