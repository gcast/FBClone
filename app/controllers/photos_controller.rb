class PhotosController < ApplicationController
	def destroy
		@photo = Photo.find(params[:id])

		if @photo.destroy
			flash[:notices] = ["Photo deleted"]
		else
			flash[:errors] = @photo.errors.full_messages
		end

		redirect_to album_url(params[:album_id])
	end

end
