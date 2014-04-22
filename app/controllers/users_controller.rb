class UsersController < ApplicationController

	def new
	end

	def create
		@user = User.new(valid_params)

		if @user.save
			log_in!(@user)
			redirect_to user_url(@user)
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to new_user_url
		end
	end

	def friends
		user = User.find(params[:id])
		@friends = user.friends
		@sent_requests = user.friendRequestAsRequestor #change to snakecase // add include to minimize query
		@received_requests = user.friendRequestAsRequestee
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def valid_params
		params.require(:user).permit(:firstName, :lastName, :email, :password, :birthDate)
	end

end
