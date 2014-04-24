class UsersController < ApplicationController

	before_action :ensure_friends_with_user!, only: [:timeline]

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
		@user = User.includes(:owned_friendships => :friend, :sent_requests => :requestee,
							  :received_requests => :requestor).find(params[:id])
	end

	def show
		@user = User.find(params[:id])	
	end

	def timeline
		@user = User.includes(:received_posts => [:author, :photos, :tagged_users]).find(params[:id])
	end

	private
	def valid_params
		params.require(:user).permit(:firstName, :lastName, :email, :password, :birthDate)
	end

end
