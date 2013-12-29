class RenameNavigationElementTitleToName < ActiveRecord::Migration
  def up
    rename_column :navigation_elements, :title, :name
  end
  def down
    rename_column :navigation_elements, :name, :title
  end
end
