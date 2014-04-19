# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Linkable

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  # References
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'

  def url
    polymorphic_path(self, :only_path => true)
  end
end
