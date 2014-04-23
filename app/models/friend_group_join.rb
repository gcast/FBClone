class FriendGroupJoin < ActiveRecord::Base

	validates :group, :friend_id, presence: true
	#validate uniqueness on all two columns

	belongs_to(
		:group,
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

end
