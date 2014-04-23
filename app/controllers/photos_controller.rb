class PhotosController < ApplicationController
	def destroy
		@photo = Photo.find(params[:id])

		if @photo.destroy
			flash[:notices] = ["Photo deleted"]
			redirect_to album_url(params[:album_id])
		else
			flash[:errors] = @photo.errors.full_messages
			redirect_to album_url(params[:album_id])
		end
	end

end
