class RemoveNameAndDepartmentFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :name, :string
    remove_column :pages, :department_id, :integer
  end
end
