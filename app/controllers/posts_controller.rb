class PostsController < ApplicationController

	def create
		@post = current_user.authored_posts.new(valid_params)
		@post.recipient_id = params[:user_id]

		unless photo_params.nil?
			photo_params.each { |params| @post.photos.new(file: params) }
    	end
	
		if !@post.save
			flash[:errors] = @post.errors.full_messages
		end

		redirect_to wall_user_url(@post.recipient_id)
	end

	def show
		@post = Post.includes(:photos, :comments, :post_tags).find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to :back
	end

	private
	def valid_params
		params.require(:post).permit(:body, :tagged_user_ids => [])
	end

	def photo_params
    	params.require(:photos) if !params[:photos].nil?
	end
end
