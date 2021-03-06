class UsersController < ApplicationController

	before_action :ensure_current_user_newsfeed, only: [:newsfeed]
	before_action :ensure_current_user!, only: [:friends, :wall, :newsfeed, :messages, :friend_message_thread]
	before_action :redirect_if_logged_in!, only: [:new]

	def new
	end

	def create
		@user = User.new(valid_params)

		if @user.save
			log_in!(@user)
			redirect_to wall_user_url(@user)
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

	def wall
		@user = User.find(params[:id])
		@albums = @user.albums
		@photos = @user.photos
		@friends = @user.friends.includes(:photos, :albums)
		@received_posts = @user.received_posts.includes(:author, :likes, :photos, :tagged_users, :comments => [:author => :photos])
	end

	def newsfeed
		@user = User.find(params[:id])
		@friends = @user.friends.includes(:photos, :albums, :authored_posts => [:author, :likes, :photos, :tagged_users, :comments => [:author => :photos]])

		@friends_postings = []

		@friends.each do |friend|
			friend.authored_posts.each { |post| @friends_postings << post }
		end
	end

	def messages
		@messages = []
		current_user.message_threads_as_one.each { |thread| @messages << thread }
		current_user.message_threads_as_two.each { |thread| @messages << thread }

		render :messages
	end

	def friend_message_thread
		user = User.find(params[:id])
		messageThreads = []
		
		current_user.message_threads_as_one.where("user_two = ?", user.id).each { |thread| messageThreads << thread }
		current_user.message_threads_as_two.where("user_one = ?", user.id).each { |thread| messageThreads << thread }

		@messageThread = messageThreads.first

		render partial: "message_threads/threadmessages", locals: { thread: @messageThread }

	end


	private
	def valid_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :birthDate)
	end

	def ensure_current_user_newsfeed
		redirect_to wall_user_url(current_user) unless params[:id].to_i == current_user.id
	end

end
