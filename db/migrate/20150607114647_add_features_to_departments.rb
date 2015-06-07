class AddFeaturesToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :feature_training_groups, :boolean, :default => true
    add_column :departments, :feature_trainers, :boolean, :default => true
    add_column :departments, :feature_messages, :boolean, :default => true
    add_column :departments, :feature_galleries, :boolean, :default => true
    add_column :departments, :feature_documents, :boolean, :default => true
    add_column :departments, :feature_events, :boolean, :default => true
  end
end
