class AddSidebarToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sidebar, :boolean, default: true
  end
end
