class CreateDepartmentsFlyersJoin < ActiveRecord::Migration
  def change
    create_table :departments_flyers, :id => false do |t|
      t.integer :department_id
      t.integer :document_id

      t.timestamps
    end
  end
end
