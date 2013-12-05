class CreateCarnivalSessions < ActiveRecord::Migration
  def change
    create_table :carnival_sessions do |t|
      t.string :name
      t.date :term

      t.timestamps
    end
  end
end
