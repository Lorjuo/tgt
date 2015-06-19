class AddSlugToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string
    add_index :pages, :slug, unique: true
    Page.all.each do |page|
      page.save! # regenerate slugs
    end
  end
end
