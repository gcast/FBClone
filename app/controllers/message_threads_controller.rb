require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]



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
			Pusher.trigger("post1", "posts:change", "")
		end

		redirect_to messages_user_url(current_user)
	end

	def show
		@messageThread = MessageThread.includes(:messages).find(params[:id])

		if request.xhr?
			render partial: "message_threads/threadmessages", locals: { thread: @messageThread }
		else
			render :show
		end
	end

end
