class AddPageableToPage < ActiveRecord::Migration
  def change
    add_column :pages, :pageable_id, :integer
    add_column :pages, :pageable_type, :string
    add_index :pages, [:pageable_id, :pageable_type]
  end
end
