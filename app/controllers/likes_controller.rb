class LikesController < ApplicationController

	before_action :ensure_current_user!

	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_to :back
	end

end
