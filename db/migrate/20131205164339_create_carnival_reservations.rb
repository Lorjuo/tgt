class CreateCarnivalReservations < ActiveRecord::Migration
  def change
    create_table :carnival_reservations do |t|
      t.integer :order_id
      t.integer :session_id
      t.integer :category_id
      t.integer :amount

      t.timestamps
    end
  end
end
