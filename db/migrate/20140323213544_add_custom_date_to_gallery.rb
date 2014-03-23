class AddCustomDateToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :custom_date, :date
  end
end
