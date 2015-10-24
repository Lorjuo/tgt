class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :residence
      t.string :phone
      t.string :email
      t.text :profession
      t.text :education
      t.text :disciplines
      t.text :activities

      t.timestamps
    end
  end
end
