class FriendshipsController < ApplicationController

	before_action :ensure_current_user!

	def destroy
		friendshipA = Friendship.find(params[:id])
		friendshipB = Friendship.where("user_id = ? AND friend_id = ?", 
								friendshipA.friend_id, friendshipA.user_id )
								.first

		friendships = [friendshipA, friendshipB]

		friendships.each do |friendship|
			FriendGroupJoin.joins(:friend_group)
						   .where("friend_id = ?", friendship.friend)
						   .where("owner_id = ?", friendship.user_id)
						   .readonly(false)
						   .destroy_all 
		end

		Friendship.transaction do 
			friendshipA.destroy
			friendshipB.destroy
		end

		redirect_to friends_user_url(current_user)
	end

end
