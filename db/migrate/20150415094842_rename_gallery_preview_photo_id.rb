class RenameGalleryPreviewPhotoId < ActiveRecord::Migration
  def up
    rename_column :galleries, :preview_photo_id, :preview_image_id
  end
  def down
    rename_column :galleries, :preview_image_id, :preview_photo_id
  end
end