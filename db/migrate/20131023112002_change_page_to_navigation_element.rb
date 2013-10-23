class ChangePageToNavigationElement < ActiveRecord::Migration
  def up
    rename_table :pages, :navigation_elements
  end
  def down
    rename_table :navigation_elements, :pages
  end
end
