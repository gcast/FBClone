class MessagesController < ApplicationController

	before_action :ensure_current_user!

	def create
		@thread = MessageThread.find(params[:message_thread_id])

		recipient_id = @thread.user_one.to_i == current_user.id ? @thread.user_two : @thread.user_one

		@message = @thread.messages.new({
			sender_id: current_user.id,
			recipient_id: recipient_id,
			message: params[:message]
		})

		if @message.save
			#do something?
		else 
			flash[:errors] = ["There was a problem sending your message"]
		end

		if request.xhr?
			render partial: "messages/message", locals: { message: @message }
		else
			redirect_to message_thread_url(@thread)
		end
	end

	# def destroy

	# end

end