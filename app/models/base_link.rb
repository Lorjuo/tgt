class BaseLink < ActiveRecord::Base # Stub for child classes in polymorphic association

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true
  
  # after_initialize do
  #   self.link ||= self.build_link
  # end

  # def url
  #   self
  # end

end