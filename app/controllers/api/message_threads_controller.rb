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
		end

		render json: @messageThread
	end

	def show
		@messageThread = MessageThread.find(params[:id])
		render json: @messageThread.to_json(include: :messages)
	end

	def index
		@messages = []

		current_user.message_threads_as_one.each { |thread| @messages << thread }
		current_user.message_threads_as_two.each { |thread| @messages << thread }

		render json: @messages
	end


end
