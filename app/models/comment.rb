class Comment < ActiveRecord::Base

	validates :comment, :author_id, presence: true

	after_commit :send_notification

	belongs_to :commentable, polymorphic: true
	
	has_many :notifications, as: :notifiable, dependent: :destroy
	has_one :location, as: :locationable, dependent: :destroy
	
	belongs_to(
		:author, 
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id
	)

	def send_notification
		unless current_user.id == self.commentable.recipient_id
			self.notifications.create(user_id: self.commentable.recipient_id, event_id: 3) 
		end
	end

end
