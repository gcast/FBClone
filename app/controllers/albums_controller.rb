class AlbumsController < ApplicationController

	def create
		@album = current_user.albums.new(valid_params)

		unless params[:photos].nil?
			params[:photos].each do |file_params|
      			@album.photos.new(file: file_params)
    		end
    	end

    	if @album.save
    		flash[:notices] = ["Album: #{@album.name} was successfully created"]
    		redirect_to user_albums_url(current_user)
    	else
    		flash[:errors] = @album.errors.full_messages
    		redirect_to user_albums_url(current_user)
    	end
	end

	def new
	end

	def destroy
		@album = Album.find(params[:id])

		if @album.destroy
			flash[:notices] = ["Album successfully deleted"]
			redirect_to user_albums_url(params[:user_id])
		else
			flash[:errors] = @album.errors.full_messages
			redirect_to user_albums_url(params[:user_id])
		end
	end

	def index
		@user = User.find(params[:user_id])
		@albums = @user.albums.includes(:photos)
	end

	def show
		@album = Album.find(params[:id])
	end

	private
	def valid_params
		params.require(:album).permit(:name)
	end

end
