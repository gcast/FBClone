class Friendship < ActiveRecord::Base

	validates :user_id, :friend_id, presence: true
	validates :user_id, :uniqueness => { :scope => :friend_id }
	after_commit :send_notification

	has_many :notifications, as: :notifiable, dependent: :destroy

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

	def send_notification
		self.notifications.create(user_id: self.user_id, event_id: 2)
	end

end
