class FriendshipsController < ApplicationController

	def destroy
		friendshipA = Friendship.find(params[:id])
		friendshipB = Friendship.where("user_id = ? AND friend_id = ?", 
								friendshipA.friend_id, friendshipA.user_id )
								.first

		Friendship.transaction do 
			friendshipA.destroy
			friendshipB.destroy
		end

		redirect_to friends_user_url(current_user)
	end

end
