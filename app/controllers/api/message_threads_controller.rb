require 'pusher'

Pusher.app_id = '73737'
Pusher.key = '69f375190cbaa886558e'
Pusher.secret = '7f3331f8c5e440d5e6ce'

class Api::MessageThreadsController < ApplicationController

	def create
		@messageThread = current_user.message_threads_as_one.new({ user_two: params[:user_two] })
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
