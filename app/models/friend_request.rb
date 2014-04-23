class FriendRequest < ActiveRecord::Base

	validates_uniqueness_of :requestor_id, :scope => [:requestor_id, :requestee_id]
	validates_uniqueness_of :requestee_id, :scope => [:requestor_id, :requestee_id]
	validates :requestor_id, :requestee_id, presence: true
	after_commit :send_notification

	has_many :notifications, as: :notifiable, dependent: :destroy

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

	def send_notification
		self.notifications.create(user_id: self.requestee_id, event_id: 1)
	end

end
