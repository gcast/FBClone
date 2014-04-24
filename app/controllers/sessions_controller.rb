class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_credentials(params[:user][:email], params[:user][:password])

		if @user
			log_in!(@user)
			redirect_to user_url(@user)
		else
			flash[:errors] = ["Invalid login credentials"]
			redirect_to new_session_url
		end
	end

	def destroy
		log_out!
		redirect_to new_session_url
	end

end
