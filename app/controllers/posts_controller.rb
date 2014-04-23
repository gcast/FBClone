class PostsController < ApplicationController

	def create
		@post = current_user.authored_posts.new(valid_params)
		@post.recipient_id = params[:user_id]

		unless params[:photos].nil?
			params[:photos].each do |file_params|
      			@post.photos.new(file: file_params)
    		end
    	end
	
		if @post.save
			redirect_to user_url(@post.recipient_id)
		else
			redirect_to user_url(@post.recipient_id)
		end
	end

	def show
		@post = Post.includes(:photos, :comments, :post_tags).find(params[:id])
	end

	private
	def valid_params
		params.require(:post).permit(:body, :tagged_user_ids => [])
	end

	#Can I just write in line 8?
	# def photo_params
 #    	params.require(:photos)
	# end
end
