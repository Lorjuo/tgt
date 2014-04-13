class MediaLink < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  # after_initialize do
  #   self.link ||= self.build_link
  # end

  def url
    # http://stackoverflow.com/questions/5316290/get-model-class-from-symbol
    klass = controller_id.classify.constantize
    action_id = 'show'
    if instance_id.present?
      instance = klass.find(instance_id)

      if ["show"].include? action_id
        polymorphic_path(instance, :only_path => true)
      else
        polymorphic_path(instance, :action => action_id, :only_path => true)
      end
    end
  end
  
end
