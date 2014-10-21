module Linkable
  extend ActiveSupport::Concern

  included do
    # Delegations
    delegate :department, :to => :link
    delegate :name, :to => :link
    delegate :parent, :to => :link
    delegate :active, :to => :link

    # Fix for touch invocation chain
    after_save do
      self.link.touch
    end
  end
end
