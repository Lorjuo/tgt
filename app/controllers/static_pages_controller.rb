class StaticPagesController < ApplicationController
  load_and_authorize_resource :class => false

  def home
    @announcements = Announcement.active
    @messages = Message.limit(3)
  end
end
