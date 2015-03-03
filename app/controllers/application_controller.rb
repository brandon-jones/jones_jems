class ApplicationController < ActionController::Base
  include ActualBack
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :debug_title if Rails.env.development?
  after_filter :actual_back

  def debug_header(text)
    bars = "=" *80
    Rails.logger.debug("\n\e[1;31m#{bars}\n#{text}\n#{bars}\e[0m")
  end

  def debug_title
    debug_header("#{params[:controller]} - #{params[:action]}")
  end

  def actual_back
    set_last_path request.env['PATH_INFO']
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  helper_method :last_path

  def authenticated
    unless current_user
      flash[:notice] = "You need to log in to visit that page"
      redirect_to root_path
    end
  end

  def authenticated_admin?
    unless current_user && current_user.admin?
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to root_path
    end
  end
  helper_method :authenticated_admin?

end
