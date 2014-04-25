class AlbumsController < ApplicationController

	before_action :ensure_friends_with_user!, only: [:index]

	def new
	end

	def create
		album = current_user.albums.new(valid_params)

		unless photo_params.nil?
			photo_params.each { |params| album.photos.new(file: params) }
    	end

    	if album.save
    		flash[:notices] = ["Album: #{album.name} was successfully created"]
    	else
    		flash[:errors] = album.errors.full_messages
    	end

    	redirect_to user_albums_url(current_user)
	end

	def destroy
		@album = Album.find(params[:id])

		if @album.destroy
			flash[:notices] = ["Album successfully deleted"]	
		else
			flash[:errors] = @album.errors.full_messages
		end

		redirect_to user_albums_url(params[:user_id])
	end

	def index
		@user = User.includes(:albums => :photos).find(params[:user_id])
	end

	#Should nest under users to ensure friend validation before action?
	def show
		@album = Album.find(params[:id])
	end

	private
	def valid_params
		params.require(:album).permit(:name)
	end

	def photo_params
		params.require(:photos) if !params[:photos].nil?
	end
end
