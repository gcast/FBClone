class Post < ActiveRecord::Base
	validates :body, :author_id, presence: true

	after_commit :send_notification

	has_many :comments, as: :commentable
	has_many :photos, as: :imageable
	has_many :notifications, as: :notifiable, dependent: :destroy
	has_many :shares, as: :shareable, inverse_of: :shareable, dependent: :destroy
	has_many :likes, as: :likeable, inverse_of: :likeable, dependent: :destroy

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

	#Already assumes current_user is not author && they are friends
	def viewable_by_current_user?
		user_received_shares = current_user.received_shares
		#No overlap between user received shares and post shares
		(user_received_shares - self.shares).length != user_received_shares.length
	end

end
