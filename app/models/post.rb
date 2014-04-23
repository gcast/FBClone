class Post < ActiveRecord::Base
	validates :body, :author_id, presence: true
	after_commit :send_notification

	has_many :comments, as: :commentable
	has_many :photos, as: :imageable
	has_many :notifications, as: :notifiable, dependent: :destroy

	belongs_to(
		:author, 
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id
	)

	has_many(
		:post_tags,
		class_name: "PostTag",
		foreign_key: :post_id,
		primary_key: :id, 
		inverse_of: :post
	)

	has_many :tagged_users, through: :post_tags, source: :person_tagged

	def send_notification
		self.notifications.create(user_id: self.recipient_id, event_id: 6)
	end

end
