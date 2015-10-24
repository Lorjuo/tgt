class AddActionIdToMediaLinks < ActiveRecord::Migration
  def change
    add_column :media_links, :action_id, :integer
  end
end
