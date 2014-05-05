class FriendGroupJoinsController < ApplicationController

	def destroy
		friend_group_join = FriendGroupJoin.find(params[:id])

		friend_group_join.destroy 

		redirect_to :back
	end

end
