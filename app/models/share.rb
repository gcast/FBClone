class Share < ActiveRecord::Base

	validates :shareable, :group_id, presence: true

	belongs_to :shareable, polymorphic: true

	belongs_to(
		:friend_group,
		class_name: "FriendGroup",
		foreign_key: :group_id,
		primary_key: :id
	)

	has_many :shared_with_friends, through: :friend_group, source: :friends_in_group


	def self.create_default_share(shareable_object)
		shareable_object.shares.new({ group_id: 0 })
	end

end
