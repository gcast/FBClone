class CommentsController < ApplicationController

	before_action :ensure_current_user!

	def create

		parameter = params.keys.select {|key| !(/_id/.match(key).nil?) }.first
		type = parameter.slice(0..-4).capitalize

		@comment = current_user.authored_comments.new({
			commentable_type: type,
			commentable_id: params[parameter],
			comment: params[:comment][:comment]
		})

		if @comment.save
			#do something?
		else 
			flash[:errors] = @comment.errors.full_messages 
		end

		if request.xhr?
			render partial: "comments/comment", locals: { comment: @comment }
		else
			redirect_to :back
		end		
	end

	def destroy
		comment = Comment.find(params[:id])
		comment.destroy

		if request.xhr?
			#Should I render something here?
			render nothing: true
		else
			redirect_to :back
		end
	end
end
