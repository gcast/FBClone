class FriendGroup < ActiveRecord::Base

	validates :owner_id, :group_name, presence: true
	validates :group_name, uniqueness: { scope: :owner_id }

	after_commit :remove_shares, :on => [:create]

	belongs_to(
		:owner,
		class_name: "User",
		foreign_key: :owner_id,
		primary_key: :id
	)

	has_many(
		:friend_group_joins,
		class_name: "FriendGroupJoin",
		foreign_key: :group_id,
		primary_key: :id,
		inverse_of: :friend_group,
		dependent: :destroy
	)

	has_many(
		:shares,
		class_name: "Share",
		foreign_key: :group_id,
		primary_key: :id,
		dependent: :destroy
	)

	has_many :friends_in_group, through: :friend_group_joins, source: :friend

end
