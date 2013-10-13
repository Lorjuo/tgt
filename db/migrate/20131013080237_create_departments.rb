class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :training_group_ids

      t.timestamps
    end
  end
end
