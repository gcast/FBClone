require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]

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
