class FriendRequest < ActiveRecord::Base

	belongs_to(
		:requestor, 
		class_name: "User",
		foreign_key: :requestorID,
		primary_key: :id
	)

	belongs_to(
		:requestee, 
		class_name: "User",
		foreign_key: :requesteeID,
		primary_key: :id
	)

	validates_uniqueness_of :requestorID, :scope => [:requestorID, :requesteeID]
	validates_uniqueness_of :requesteeID, :scope => [:requestorID, :requesteeID]
	validates :requestorID, :requesteeID, presence: true


end
