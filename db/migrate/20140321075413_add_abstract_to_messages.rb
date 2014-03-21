class AddAbstractToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :abstract, :text
  end
end
