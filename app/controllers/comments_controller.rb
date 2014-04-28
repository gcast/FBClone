class CommentsController < ApplicationController

	def create
		parameter = params.keys.select {|key| !(/_id/.match(key).nil?) }.first
		type = parameter.slice(0..-4).capitalize

		@comment = current_user.authored_comments.new({
			commentable_type: type,
			commentable_id: params[parameter],
			comment: params[:comment][:comment]
		})

		flash[:errors] = @comment.errors.full_messages if !@comment.save
	
		redirect_to :back
	end

	def destroy
		comment = Comment.find(params[:id])
		comment.destroy
		redirect_to :back
	end
end
