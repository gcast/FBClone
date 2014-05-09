require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]

class Api::MessageThreadsController < ApplicationController

	def create
		thread = MessageThread.find_thread_with_user(current_user, params[:user_two])

		if thread
			@messageThread = thread
		else
			@messageThread = current_user.message_threads_as_one.new({ user_two: params[:user_two] })
		end

		@firstMessage = @messageThread.messages.new({ 
			sender_id: current_user.id,
			recipient_id: params[:user_two],
			message: params[:first_message]
		})

		Message.transaction do
			@messageThread.save
			@firstMessage.save	
			Pusher.trigger("post1", "posts:change", "")
		end

		render json: @messageThread.to_json(include: :messages)
	end

	def show
		@messageThread = MessageThread.find(params[:id])
		render json: @messageThread.to_json(include: :messages)
	end

	def index
		@messageThreads = []

		current_user.message_threads_as_one.each { |thread| @messageThreads << thread }
		current_user.message_threads_as_two.each { |thread| @messageThreads << thread }

		render json: @messageThreads.to_json(include: :messages)
	end


end
