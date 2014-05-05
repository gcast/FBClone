require 'pusher'

Pusher.app_id = '73737'
Pusher.key = '69f375190cbaa886558e'
Pusher.secret = '7f3331f8c5e440d5e6ce'

class Api::MessagesController < ApplicationController

	def create
		@thread = MessageThread.find(params[:message_thread_id])

		recipient_id = @thread.user_one.to_i == current_user.id ? @thread.user_two : @thread.user_one

		@message = @thread.messages.new({
			sender_id: current_user.id,
			recipient_id: recipient_id,
			message: params[:message]
		})

		if @message.save
			Pusher.trigger("post1", "posts:change", "")
		end

		render json: @message

	end

	def show
		@message = Message.find(params[:id])
		render json: @message
	end
	
end
