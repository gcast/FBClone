class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def log_in!(user)
  	session[:session_token] = user.reset_session_token!
    current_user.turn_on_session_active!
  end

  def log_out!
    current_user.turn_off_session_active!
  	current_user.reset_session_token!  
  	session[:session_token] = nil
  end

  def current_user
  	return nil unless session[:session_token]
  	@current_user ||= User.find_by_session_token(session[:session_token])
  end

  def ensure_current_user!
      redirect_to new_session_url unless current_user
  end

  def redirect_if_logged_in!
      redirect_to wall_user_url(current_user) if current_user
  end


end
