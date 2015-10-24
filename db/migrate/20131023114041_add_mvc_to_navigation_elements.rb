class AddMvcToNavigationElements < ActiveRecord::Migration
  def change
    add_column :navigation_elements, :controller_id, :string
    add_column :navigation_elements, :action_id, :string
    add_column :navigation_elements, :instance_id, :integer
  end
end
