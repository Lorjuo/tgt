class AlterReference < ActiveRecord::Migration
  def change
    add_column :references, :reference_from_id, :integer
    add_column :references, :reference_from_type, :string
    add_index :references, [:reference_from_id, :reference_from_type]

    remove_column :references, :message_id
  end
end
