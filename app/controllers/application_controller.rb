class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def log_in!(user)
  	session[:session_token] = user.reset_session_token!
  end

  def log_out!
  	current_user.reset_session_token!
  	session[:session_token] = nil
  end

  #JUST AS CURRENT_USER IS SAVED AS IVAR, STORE OTHER INFO AS IVARS THAT 
  #ARE HARD TO INCLUDE IN ASSOCIATIONS (E.G. SEARCHABLE)

  def current_user
  	return nil unless session[:session_token]
  	@current_user ||= User.find_by_session_token(session[:session_token])
  end

  # def ensure_friends_with_user!
  #   id = params[:id].nil? ? params[:user_id] : params[:id]
  #   user = User.find(id)

  #   if (user.id != current_user.id) && !current_user.friends_with?(user)
  #     flash[:notices] = ["You have to be friends with this user."]
  #     redirect_to user_url(user)
  #   end
  # end

end
