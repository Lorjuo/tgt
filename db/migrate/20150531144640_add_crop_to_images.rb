class AddCropToImages < ActiveRecord::Migration
  def change
    # Adding cropping columns for later recreation of image versions
    add_column :images, :file_crop_x, :float
    add_column :images, :file_crop_y, :float
    add_column :images, :file_crop_w, :float
    add_column :images, :file_crop_h, :float
  end
end
