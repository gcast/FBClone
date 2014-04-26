class PostTag < ActiveRecord::Base

	validates :post, :tagged_user_id, presence: true
	validates :post_id, uniqueness: { scope: :tagged_user_id }

	after_commit :send_notification

	has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

	belongs_to(
		:post,
		class_name: "Post",
		foreign_key: :post_id,
		primary_key: :id
	)

	belongs_to(
		:person_tagged,
		class_name: "User",
		foreign_key: :tagged_user_id,
		primary_key: :id
	)

	def send_notification
		self.notifications.create(user_id: self.tagged_user_id, event_id: 5)
	end
end
