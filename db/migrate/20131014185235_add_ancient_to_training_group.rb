class AddAncientToTrainingGroup< ActiveRecord::Migration
  def change
    add_column :training_groups, :ancient, :boolean
  end
end
