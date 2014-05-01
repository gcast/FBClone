class Api::UsersController < ApplicationController

	# before_action :ensure_friends_with_user!, only: [:wall]
	# before_action :reroute_to_wall_if_friends!, only: [:show]
	# before_action :ensure_current_user_newsfeed, only: [:newsfeed]

	# def new
	# end

	# def create
	# 	@user = User.new(valid_params)

	# 	if @user.save
	# 		log_in!(@user)
	# 		redirect_to wall_user_url(@user)
	# 	else
	# 		flash[:errors] = @user.errors.full_messages
	# 		redirect_to new_user_url
	# 	end
	# end

	# #Can minimize queries further?
	# def friends
	# 	@user = User.includes(:owned_friendships => :friend, :sent_requests => :requestee,
	# 						  :received_requests => :requestor).find(params[:id])
	# end

	# def wall
	# 	@user = User.find(params[:id])
	# 	@albums = @user.albums
	# 	@photos = @user.photos
	# 	@friends = @user.friends.includes(:photos, :albums)
	# 	@received_posts = @user.received_posts.includes(:author, :likes, :photos, :tagged_users, :comments => [:author => :photos])
	# end

	# def newsfeed
	# 	@user = User.find(params[:id])
	# 	@friends = @user.friends.includes(:photos, :albums, :authored_posts => [:author, :likes, :photos, :tagged_users, :comments => [:author => :photos]])

	# 	@friends_postings = []

	# 	@friends.each do |friend|
	# 		friend.authored_posts.each { |post| @friends_postings << post }
	# 		#Can add more later like friend photo updates, new friendships etc...
	# 	end

	# end

	# def messages
	# 	@messages = []
	# 	current_user.message_threads_as_one.each { |thread| @messages << thread }
	# 	current_user.message_threads_as_two.each { |thread| @messages << thread }

	# 	render :messages
	# end

	def show
		@user = User.find(params[:id])
		render json: @user
	end

	def index
		@users = User.all
		render json: @users
	end


	# private
	# def valid_params
	# 	params.require(:user).permit(:first_name, :last_name, :email, :password, :birthDate)
	# end

	# def ensure_current_user_newsfeed
	# 	unless params[:id].to_i == current_user.id
	# 		redirect_to wall_user_url(current_user)
	# 	end
	# end

end
