class AddCustomDateToMessage < ActiveRecord::Migration
  def up
    add_column :messages, :custom_date, :date
    # http://stackoverflow.com/questions/849897/can-rails-migrations-be-used-to-convert-data
    Message.all.each do |message|
       message.custom_date = message.created_at.to_date
       message.save
    end
  end

  def down
    remove_column :messages, :custom_date
  end
end
