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

	#Can minimize queries further?
	def friends
		@user = User.find(params[:id])
		@friendships = @user.owned_friendships.includes(:friend)
		@sent_requests = @user.sent_requests.includes(:requestee)
		@received_requests = @user.received_requests.includes(:requestor)
	end

	def show
		@user = User.find(params[:id])
		@received_posts = @user.received_posts.includes(:author, :photos, :tagged_users)
	end

	private
	def valid_params
		params.require(:user).permit(:firstName, :lastName, :email, :password, :birthDate)
	end

end
