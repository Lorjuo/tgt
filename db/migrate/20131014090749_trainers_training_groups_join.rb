class TrainersTrainingGroupsJoin < ActiveRecord::Migration
  def change
    create_table "trainers_training_groups", :id => false, :force => true do |t|
      t.integer "trainer_id"
      t.integer "training_group_id"
    end
  end
end
