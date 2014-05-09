class PhotosController < ApplicationController

	before_action :ensure_current_user!
	
	def destroy
		@photo = Photo.find(params[:id])

		if @photo.destroy
			flash[:notices] = ["Photo deleted"]
		else
			flash[:errors] = @photo.errors.full_messages
		end

		redirect_to :back
	end

end
