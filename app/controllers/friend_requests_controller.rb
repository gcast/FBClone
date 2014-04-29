class FriendRequestsController < ApplicationController

	def create
		requestee_id = params[:user_id]
		@friendship_request = current_user.sent_requests.new({requestee_id: requestee_id})

		if @friendship_request.save
			flash[:notices] = ["Friend Request Sent"]
		else
			flash[:errors] = @friendship_request.errors.full_messages		
		end

		redirect_to wall_user_url(requestee_id)
	end

	def accept
		request = FriendRequest.find(params[:id])
		requestor_id = request.requestor.id
		requestee_id = request.requestee.id

		Friendship.transaction do 
			Friendship.new({ user_id: requestor_id, friend_id: requestee_id }).save!
			Friendship.new({ user_id: requestee_id, friend_id: requestor_id }).save!
			request.destroy
		end
		
		redirect_to wall_user_url(current_user)
	end

	def decline
		request = FriendRequest.find(params[:id])

		if !request.destroy
			flash[:errors] = ["There was a problem deleting your friend request"]
		end

		redirect_to wall_user_url(current_user)
	end

end
