class AddVisibleToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :visible_from, :date
    add_column :messages, :visible_to, :date
    add_column :messages, :published, :boolean#, :default => true
    Message.all.each do |message|
      message.published = true
      message.save!
    end
  end
end
