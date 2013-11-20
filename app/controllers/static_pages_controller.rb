class StaticPagesController < ApplicationController
  load_and_authorize_resource :class => false

  layout "two_columns"

  def home
    @messages = Message.limit(3)
  end

  def page_layout

  end
end
