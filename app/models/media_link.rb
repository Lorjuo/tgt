# == Schema Information
#
# Table name: media_links
#
#  id            :integer          not null, primary key
#  controller_id :string(255)
#  instance_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class MediaLink < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Linkable

  # Associations
  has_one :link, :as => :linkable, :dependent => :destroy

  accepts_nested_attributes_for :link, :allow_destroy => true

  # Validations
  validates :controller_id, :presence => true

  # after_initialize do
  #   self.link ||= self.build_link
  # end

  def url

     # TODO bug with controllers without models e.g. StaticPages
    if controller_id.blank?
      "#"
    elsif instance_id.nil?
      url_for :controller => controller_id, :action => action_id, :only_path => true
    else
      # http://stackoverflow.com/questions/5316290/get-model-class-from-symbol
      klass = controller_id.classify.constantize
      if instance_id.present?
        instance = klass.find(instance_id)

        if ["show"].include? action_id
          polymorphic_path(instance, :only_path => true)
        else
          polymorphic_path(instance, :action => action_id, :only_path => true)
        end
      end
    end

    # # Media Link only:
    # # http://stackoverflow.com/questions/5316290/get-model-class-from-symbol
    # klass = controller_id.classify.constantize
    # action_id = 'show'
    # if instance_id.present?
    #   instance = klass.find(instance_id)

    #   if ["show"].include? action_id
    #     polymorphic_path(instance, :only_path => true)
    #   else
    #     polymorphic_path(instance, :action => action_id, :only_path => true)
    #   end
    # end
  end
  
end
