class CreateCarnivalOrders < ActiveRecord::Migration
  def change
    create_table :carnival_orders do |t|
      t.integer :person_id
      t.string :notice

      t.timestamps
    end
  end
end
