class Friendship < ActiveRecord::Base

	validates :userID, :friendID, presence: true
	validates :userID, :uniqueness => { :scope => :friendID }

	belongs_to(
		:owner, 
		class_name: "User",
		foreign_key: :userID,
		primary_key: :id
	)

	belongs_to(
		:friend,
		class_name: "User",
		foreign_key: :friendID,
		primary_key: :id
	)

end
