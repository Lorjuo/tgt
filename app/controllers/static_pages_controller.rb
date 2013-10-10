class StaticPagesController < ApplicationController
  load_and_authorize_resource :class => false

  def home
  end
end
