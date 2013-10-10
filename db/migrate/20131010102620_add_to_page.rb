class AddToPage < ActiveRecord::Migration
  # def change
  #   add_column :pages, :parent_id, :integer
  #   add_column :pages, :lft, :integer
  #   add_column :pages, :rgt, :integer
  # end
  
  NESTED_SET_COLUMNS = [:parent_id, :lft, :rgt, :depth]

  def up
    NESTED_SET_COLUMNS.each do |column|
      add_column :pages, column, :integer
    end

    if defined?(Page) && Page.respond_to?(:rebuild!)
      Page.rebuild!
    end
  end

  def down
    NESTED_SET_COLUMNS.each do |column|
      remove_column :pages, column
    end
  end
end
