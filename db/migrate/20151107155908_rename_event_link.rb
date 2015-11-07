class RenameEventLink < ActiveRecord::Migration
  def change
    rename_column :events, :link, :url
  end
end
