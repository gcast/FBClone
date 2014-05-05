class OnlineFriendsController < ApplicationController

	def index
		@online_friends = current_user.friends.where("session_active = true") 
		
		render partial: "/users/onlinefriends", locals: {online_friends: @online_friends}
	end

end
