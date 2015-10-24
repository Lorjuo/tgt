class CreateTrainingGroups < ActiveRecord::Migration
  def change
    create_table :training_groups do |t|
      t.string :name
      t.text :description
      t.integer :department_id
      t.integer :age_begin
      t.integer :age_end

      t.timestamps
    end
  end
end
