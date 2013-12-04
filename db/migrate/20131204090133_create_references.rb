class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :message_id

      t.integer :reference_to_id
      t.string :reference_to_type
      t.index [:reference_to_id, :reference_to_type]

      t.timestamps
    end
  end
end
