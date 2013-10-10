class Page < ActiveRecord::Base
  include TheSortableTree::Scopes

  # Columns in the categories table: lft, rgt and parent_id
  #acts_as_nested_set :scope => :navigation_id
  acts_as_nested_set  :after_add      => :invoke_touch, # these callbacks seem not to be triggered
                      :after_remove   => :invoke_touch

  # Invoke touch on parent, to update timestamp for fragment caching
  # declaring this in the association is not possible:
  # see: https://github.com/collectiveidea/awesome_nested_set/blob/master/lib/awesome_nested_set/awesome_nested_set.rb, line 66
  #before_save :invoke_touch
  #before_destroy :invoke_touch
  
  validates :title, presence: true

  def invoke_touch
    self.touch
    parent.invoke_touch unless parent.nil?
  end
end
