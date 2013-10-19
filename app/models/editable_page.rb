class EditablePage < ActiveRecord::Base

  # Associations
  has_one :page, :as => :pageable, :dependent => :destroy

  accepts_nested_attributes_for :page, :allow_destroy => true

  # after_initialize do
  #   self.page ||= self.build_page
  # end

  def url
    self
  end
end
