class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name

      t.timestamps
    end

    Area.create(:name => 'Sport')
    Area.create(:name => 'Kultur')
    Area.create(:name => 'Verein')
  end
end
