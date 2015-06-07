class AddActiveToQuickLinks < ActiveRecord::Migration
  def change
    add_column :quick_links, :active, :boolean, :default => true
  end
end
