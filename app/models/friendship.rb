class Friendship < ActiveRecord::Base

	validates :user_id, :friend_id, presence: true
	validates :user_id, :uniqueness => { :scope => :friend_id }

	belongs_to(
		:owner, 
		class_name: "User",
		foreign_key: :user_id,
		primary_key: :id
	)

	belongs_to(
		:friend,
		class_name: "User",
		foreign_key: :friend_id,
		primary_key: :id
	)

end
