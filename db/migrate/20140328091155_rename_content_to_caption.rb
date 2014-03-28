class RenameContentToCaption < ActiveRecord::Migration
  def change
    rename_column :announcements, :content, :caption
  end
end
