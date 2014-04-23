class FriendRequest < ActiveRecord::Base

	belongs_to(
		:requestor, 
		class_name: "User",
		foreign_key: :requestor_id,
		primary_key: :id
	)

	belongs_to(
		:requestee, 
		class_name: "User",
		foreign_key: :requestee_id,
		primary_key: :id
	)

	validates_uniqueness_of :requestor_id, :scope => [:requestor_id, :requestee_id]
	validates_uniqueness_of :requestee_id, :scope => [:requestor_id, :requestee_id]
	validates :requestor_id, :requestee_id, presence: true


end
