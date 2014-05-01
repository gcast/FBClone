class Api::MessagesController < ApplicationController

	# def create
	# 	@thread = MessageThread.find(params[:message_thread_id])

	# 	recipient_id = @thread.user_one.to_i == current_user.id ? @thread.user_two : @thread.user_one

	# 	@message = @thread.messages.new({
	# 		sender_id: current_user.id,
	# 		recipient_id: recipient_id,
	# 		message: params[:message]
	# 	})

	# 	if @message.save
	# 		redirect_to message_thread_url(@thread)
	# 	else
	# 		flash[:errors] = ["There was a problem sending your message"]
	# 		redirect_to message_thread_url(current_user)
	# 	end
	# end

	# def destroy

	# end

	def show
		@message = Message.find(params[:id])
		render json: @message
	end

	
end
