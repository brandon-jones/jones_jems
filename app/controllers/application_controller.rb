class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :debug_title if Rails.env.development?

  def debug_header(text)
    bars = "=" *80
    Rails.logger.debug("\n\e[1;31m#{bars}\n#{text}\n#{bars}\e[0m")
  end

  def debug_title
    debug_header("#{params[:controller]} - #{params[:action]}")
  end
end
