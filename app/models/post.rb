class Post < ActiveRecord::Base

	include PgSearch
	multisearchable :against => [:body]

	validates :body, :author_id, presence: true

	after_commit :send_notification

	has_many :comments, as: :commentable, dependent: :destroy
	has_many :photos, as: :imageable, dependent: :destroy

	has_one :location, as: :locationable, inverse_of: :locationable, dependent: :destroy

	has_many :notifications, as: :notifiable, dependent: :destroy
	has_many :shares, as: :shareable, inverse_of: :shareable, dependent: :destroy
	has_many :likes, as: :likeable, inverse_of: :likeable, dependent: :destroy

	belongs_to(
		:author, 
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id
	)

	belongs_to(
		:recipient, 
		class_name: "User",
		foreign_key: :recipient_id,
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
		self.notifications.create(user_id: self.recipient_id, event_id: 5) unless current_user.id == self.recipient_id
	end

	def viewable_by_user?(user)
		user_received_shares = user.received_shares
		post_shares = self.shares

		#User can see if the user wrote the post
		self.author == user ||
		#User can see if the post was written on the user's wall
		self.recipient_id == user.id ||
		#By default if no explicit shares, element is shared across all friends
		post_shares.empty? ||
		#If explicit shares exist there should be an overlap so the new array's length != share's length
		(user_received_shares - post_shares).length != user_received_shares.length
	end

end
