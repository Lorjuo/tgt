class AddThemeToLinks < ActiveRecord::Migration
  def change
    add_column :links, :theme_id, :integer
  end
end
