class RenameFlyerNavigationElementsToDocument < ActiveRecord::Migration
  def up
    NavigationElement.all.where(:action_id => 'flyers').each{|element| element.action_id = 'documents'; element.name = 'Dokumente'; element.save! }
  end
  def down
    NavigationElement.all.where(:action_id => 'documents').each{|element| element.action_id = 'flyers'; element.name = 'Flyer'; element.save! }
  end
end
