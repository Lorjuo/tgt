class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization :if => :custom_check_authorization?

  before_filter :_miniprofiler, :_cancan_sanitizer

  # Not in use because nearly every page is readable
  # before_filter :authenticate_user! 

  # rescue_from CanCan::AccessDenied do |exception|
  #   if user_signed_in?
  #     redirect_to root_url, :alert => exception.message
  #   else
  #     #redirect_to new_user_session_path, :alert => exception.message
  #     redirect_to({ :controller => 'devise/sessions', :action => 'new', :referring_page => request.path }, :alert => exception.message)
  #   end
  # end

  # Redirect to a specific page on successful sign in
  def after_sign_in_path_for(resource)
    params[:user][:referring_page] || super
  end

  def _miniprofiler
    if %w(development staging).include?(Rails.env)
      if APP_CONFIG['debug']['miniprofiler_enabled'] && user_signed_in? && current_user.has_role?('admin')
        Rack::MiniProfiler.authorize_request
      else
        Rack::MiniProfiler.deauthorize_request
      end
    end
  end

  # Apply strong_parameters filtering before CanCan authorization
  # See https://github.com/ryanb/cancan/issues/571#issuecomment-10753675
  def _cancan_sanitizer
  #before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  private

  def custom_check_authorization?
    if devise_controller?
      return false
    # Fix for ckeditor to work with cancan
    # https://github.com/ssendev/ckeditor/commit/5e1d83346e7f94a1cbe1f06cadb660a1a0ef042f
    # Solved meanwhile
    # NOTE: can probably be removed in next release: >4.0.6
    elsif params[:controller] == 'ckeditor/pictures' || params[:controller] == 'ckeditor/attachment_files'
      return false
    end

    return true
  end
end
