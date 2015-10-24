class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name
      t.text :content
      t.string :link
      t.boolean :active

      t.timestamps
    end
  end
end
