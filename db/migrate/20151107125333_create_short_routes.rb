class CreateShortRoutes < ActiveRecord::Migration
  def change
    create_table :short_routes do |t|
      t.string :name
      t.string :url
      t.integer :http_status, :default => 301 # default to :permanent

      t.timestamps
    end

    add_index :short_routes, :name
  end
end
