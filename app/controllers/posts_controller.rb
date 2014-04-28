class PostsController < ApplicationController

	def create
		@post = current_user.authored_posts.new(valid_params)
		@post.recipient_id = params[:user_id]

		# Share.create_default_share(@post)
		
		unless share_params.nil?
			share_params[:group_ids].map(&:to_i).each { |id| @post.shares.new({ group_id: id }) }
		end
		
		unless photo_params.nil?
			photo_params.each { |params| @post.photos.new(file: params) }
    	end
	
		if @post.save
			flash[:notices] = ["Post saved successfully"]
		else
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

	def like
		@post = Post.find(params[:id])
		@post.likes.create({ liker_id: current_user.id })
		redirect_to :back
	end

	private
	def valid_params
		params.require(:post).permit(:body, :tagged_user_ids => [])
	end

	def photo_params
    	params.require(:photos) if !params[:photos].nil?
	end

	def share_params
		params.require(:share).permit(:group_ids => []) if !params[:share].nil?
	end
end
