class JoinCarnivalSessionCategory < ActiveRecord::Migration
  def change
    create_table "carnival_sessions_categories", :id => false, :force => true do |t|
      t.integer "session_id"
      t.integer "category_id"
    end
  end
end
