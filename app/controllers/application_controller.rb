class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #check_authorization :unless => :devise_controller?

  before_filter :_miniprofiler

  # Not in use because nearly every page is readable
  # before_filter :authenticate_user! 

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url, :alert => exception.message
    else
      #redirect_to new_user_session_path, :alert => exception.message
      redirect_to({ :controller => 'devise/sessions', :action => 'new', :referring_page => request.path }, :alert => exception.message)
    end
  end

  # Redirect to a specific page on successful sign in
  def after_sign_in_path_for(resource)
    params[:user][:referring_page] || super
  end

  def _miniprofiler
    if APP_CONFIG['debug']['miniprofiler_enabled'] && user_signed_in? && current_user.has_role?('admin')
      Rack::MiniProfiler.authorize_request
    else
      Rack::MiniProfiler.deauthorize_request
    end
  end
end
