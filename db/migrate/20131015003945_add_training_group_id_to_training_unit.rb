class AddTrainingGroupIdToTrainingUnit < ActiveRecord::Migration
  def change
    add_column :training_units, :training_group_id, :integer
  end
end
