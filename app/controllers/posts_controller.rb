class PostsController < ApplicationController

	def create
		@post = current_user.authored_posts.new(valid_params)
		@post.recipient_id = params[:user_id]


		unless share_params.nil?
			share_params[:group_ids].map(&:to_i).each { |id| @post.shares.new({ group_id: id }) }
		end
		
		unless photo_params.nil?
			photo_params.each { |params| @post.photos.new(file: params) }
    	end

    	unless loc_params[:long].nil? || loc_params[:lat].nil?
    		location = @post.build_location({
				long: params[:location][:long].to_f,
				lat: params[:location][:lat].to_f
			})
    	end
	
		if @post.save
			#do something
		else
			flash[:errors] = @post.errors.full_messages
		end

		if request.xhr?
			render partial: "posts/post", locals: {post: @post}
		else
			redirect_to wall_user_url(@post.recipient_id)
		end

	end

	def show
		@post = Post.includes(:photos, :comments, :post_tags).find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		

		if request.xhr?
			#What should I render?
			render nothing: true
		else
			redirect_to :back
		end
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

	def loc_params
		params.require(:location).permit(:long, :lat)
	end
end
