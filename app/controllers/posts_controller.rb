class PostsController < ApplicationController

	def create
		@post = current_user.authored_posts.new(valid_params)
		@post.recipient_id = params[:user_id]
	
		if @post.save
			redirect_to user_url(@post.recipient_id)
		else
			redirect_to user_url(@post.recipient_id)
		end
	end

	private
	def valid_params
		params.require(:post).permit(:body, :tagged_user_ids => [])
	end
end
