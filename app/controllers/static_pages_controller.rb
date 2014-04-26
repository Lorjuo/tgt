class StaticPagesController < ApplicationController
  load_and_authorize_resource :class => false

  layout :resolve_layout

  def home
    @messages = Message.chronological.limit(5)
  end

  def page_layout

  end

  def media_box

  end

  def resolve_layout
    case action_name
    when "media_box"
      false
    else
      "two_columns"
    end
  end
end
