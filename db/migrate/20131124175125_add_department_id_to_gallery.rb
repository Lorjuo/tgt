class AddDepartmentIdToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :department_id, :integer
  end
end
