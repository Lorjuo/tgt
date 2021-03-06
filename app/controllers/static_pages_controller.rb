class StaticPagesController < ApplicationController
  load_and_authorize_resource :class => false

  layout :resolve_layout

  def home
    @messages = Message.chronological.limit(7)

    unless user_signed_in?
      @messages = @messages.published
    end
  end

  def page_layout
  end

  def media_box
  end

  def download_button
  end

  def row
  end

  def resolve_layout
    case action_name
    when "media_box", 'download_button', 'row'
      false #'minimal'
    else
      "two_columns"
    end
  end
end
