class AddPreviewImageToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :preview_image_id, :integer
  end
end
