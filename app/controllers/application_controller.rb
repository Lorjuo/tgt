class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization :if => :custom_check_authorization?

  before_filter :_miniprofiler, :set_locale, :set_theme #, :_cancan_sanitizer

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Not in use because nearly every page is readable
  # before_filter :authenticate_user! 

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url, :alert => exception.message
    else
      #redirect_to new_user_session_path, :alert => exception.message
      redirect_to({ :controller => 'devise/sessions', :action => 'new', :referring_page => request.path }, :alert => exception.message)
      # flash.keep
    end
  end

  #https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # # Redirect to a specific page on successful sign in
  def after_sign_in_path_for(resource)
    #if params[:user][:referring_page].present?
    if params.try(:[], :user).try(:[], :referring_page).present?
      params[:user][:referring_page]
    else
      root_path
    end
  end

  #https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # Redirect to a specific page on successful sign in
  # def after_sign_in_path_for(resource)
  #   params[:user][:referring_page] || super
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   params[:referring_page] || super
  # end

  def _miniprofiler
    if %w(development staging).include?(Rails.env)
      if APP_CONFIG['debug']['miniprofiler_enabled'] && user_signed_in? && current_user.has_role?('admin')
        Rack::MiniProfiler.authorize_request
      else
        Rack::MiniProfiler.deauthorize_request
      end
    end
  end

  # http://xyzpub.com/en/ruby-on-rails/3.2/i18n_mehrsprachige_rails_applikation.html
  # http://dasskript.blogspot.de/2009/11/einfache-lokalisierung-einer-ruby-on.html
  def set_locale
    locale = nil
    # logger.debug "* session has '#{session[:locale]}'"
    if params.has_key?('locale')
      locale = params[:locale]
      session[:locale] = locale
    else
      if session[:locale]
        locale = session[:locale]
      elsif request.env['HTTP_ACCEPT_LANGUAGE'].present?
        locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
        if locale != ""
          session[:locale] = locale
        end
      else
        locale = 'en'
      end
    end
    I18n.locale = locale
    # logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def set_theme
    if params.has_key?('theme')
      session[:theme] = params[:theme]
    elsif !session[:theme].present?
      session[:theme] = 'tagesschau'
    end
  end

  private

  def custom_check_authorization?
    if devise_controller?
      return false
    end

    return true
  end

  # http://stackoverflow.com/questions/16852377/custom-user-fields-in-devise-3-under-rails-4
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
end
