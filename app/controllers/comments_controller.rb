class CommentsController < ApplicationController

	def create
		if params[:post_id]
			@comment = current_user.authored_comments.new({
				commentable_type: "Post",
				commentable_id: params[:post_id],
				comment: params[:comment][:comment]
			})
		elsif params[:photo_id]
			@comment = current_user.authored_comments.new({
				commentable_type: "Photo",
				commentable_id: params[:photo_id],
				comment: params[:comment][:comment]
			})
		end

		if @comment.save
			redirect_to user_url(@comment.commentable.recipient_id)
		else
			flash[:errors] = @comment.errors.full_messages
			redirect_to user_url(current_user)
		end
	end


	private

	#Necessary?
	def valid_params
		params.require(:comment).permit(:comment)
	end
end
