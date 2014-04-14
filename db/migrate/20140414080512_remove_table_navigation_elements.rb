class RemoveTableNavigationElements < ActiveRecord::Migration
  def change
    drop_table :navigation_elements
  end
end
