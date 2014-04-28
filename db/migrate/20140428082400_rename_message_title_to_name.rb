class RenameMessageTitleToName < ActiveRecord::Migration
  def change
    rename_column :messages, :title, :name
  end
end
