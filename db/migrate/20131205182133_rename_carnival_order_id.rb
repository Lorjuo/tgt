class RenameCarnivalOrderId < ActiveRecord::Migration
  def up
    rename_column :carnival_orders, :id, :order_id
  end
  def down
    rename_column :carnival_orders, :order_id, :id
  end
end
