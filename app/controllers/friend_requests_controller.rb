class FriendRequestsController < ApplicationController

	def create
		requesteeID = params[:user_id]
		@friendship_request = current_user.friendRequestAsRequestor.new({requesteeID: requesteeID})

		if @friendship_request.save
			flash[:notices] = ["Friend Request Sent"]
			redirect_to user_url(requesteeID)
		else
			flash[:errors] = @friendship_request.errors.full_messages
			redirect_to user_url(requesteeID)
		end
	end

	def accept
		request = FriendRequest.find(params[:id])
		requestorID = request.requestor.id
		requesteeID = request.requestee.id

		friendshipA = Friendship.new({ userID: requestorID, friendID: requesteeID })
		friendshipB = Friendship.new({ userID: requesteeID, friendID: requestorID })

		Friendship.transaction do 
			friendshipA.save!
			friendshipB.save!
			request.destroy
		end
		
		#Add Errors
		redirect_to user_url(current_user)
	end

	def decline
		request = FriendRequest.find(params[:id])

		if request.destroy
			redirect_to user_url(current_user)
		else
			flash[:errors] = ["There was a problem deleting your friend request"]
			redirect_to user_url(current_user)
		end
	end

end
