class Page < ActiveRecord::Base
  has_many :references, :as => :reference_from, :dependent => :destroy # polymorphic
  has_many :galleries, :through => :references, :source => :reference_to, :source_type => 'Gallery'
  has_many :documents, :through => :references, :source => :reference_to, :source_type => 'Document'
end
