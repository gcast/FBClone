class FriendGroupsController < ApplicationController
	def new
	end

	def create
		@group = current_user.created_groups.new(valid_params)

		if @group.save
			flash[:notice] = ["Your group was saved."]
			redirect_to friends_user_url(current_user)
		else
			flash[:errors] = @group.errors.full_messages
			redirect_to new_friend_group_url
		end
	end

	def index
		@friend_groups = current_user.created_groups.includes(:friends_in_group)
	end

	def destroy
		@friend_group = FriendGroup.find(params[:id])
		@friend_group.destroy

		redirect_to friend_groups_url
	end

	private
	def valid_params
		params.require(:group).permit(:group_name, :friends_in_group_ids => [])
	end
end
