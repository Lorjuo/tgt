class ChangeAttachable < ActiveRecord::Migration
  def change
    rename_column :images, :imageable_id, :attachable_id
    rename_column :images, :imageable_type, :attachable_type
    rename_column :documents, :documentable_id, :attachable_id
    rename_column :documents, :documentable_type, :attachable_type
  end
end
