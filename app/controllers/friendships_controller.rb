class FriendshipsController < ApplicationController

	def destroy
		friendshipA = Friendship.find(params[:id])
		friendshipB = Friendship.where(
			"userID = ? AND friendID = ?", friendshipA.friendID, friendshipA.userID ).first

		Friendship.transaction do 
			friendshipA.destroy
			friendshipB.destroy
		end

		redirect_to friends_user_url(current_user)
	end

end
