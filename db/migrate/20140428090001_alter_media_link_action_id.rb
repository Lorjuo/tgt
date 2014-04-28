class AlterMediaLinkActionId < ActiveRecord::Migration
  def change
    change_column :media_links, :action_id, :string
  end
end
