class FriendGroupJoin < ActiveRecord::Base

	validates :friend_group, :friend_id, presence: true

	belongs_to(
		:friend_group,
		class_name: "FriendGroup",
		foreign_key: :group_id,
		primary_key: :id
	)

	belongs_to(
		:friend,
		class_name: "User",
		foreign_key: :friend_id,
		primary_key: :id
	)

	has_one :owner, through: :friend_group, source: :owner

end
