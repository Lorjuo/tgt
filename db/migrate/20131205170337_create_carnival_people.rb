class CreateCarnivalPeople < ActiveRecord::Migration
  def change
    create_table :carnival_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :zip
      t.string :city
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
