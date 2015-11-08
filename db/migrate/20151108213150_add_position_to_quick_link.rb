class AddPositionToQuickLink < ActiveRecord::Migration
  def change
    add_column :quick_links, :position, :integer
  end
end
