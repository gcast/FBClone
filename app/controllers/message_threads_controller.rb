class MessageThreadsController < ApplicationController

	def create
		@messageThread = current_user.message_threads_as_one.new({ user_two: params[:thread][:user_two] })
		@firstMessage = @messageThread.messages.new({ 
			sender_id: current_user.id,
			recipient_id: params[:thread][:user_two],
			message: params[:thread][:first_message]
		})

		Message.transaction do
			@messageThread.save
			@firstMessage.save	
		end

		redirect_to messages_user_url(current_user)
	end

	def show
		@messageThread = MessageThread.find(params[:id])
		render :show
	end

	def destroy

	end

end
