class Message < ActiveRecord::Base

	validates :sender_id, :recipient_id, :message, :message_thread, presence: true

	belongs_to(
		:message_thread,
		class_name: "MessageThread",
		foreign_key: :thread_id,
		primary_key: :id,
		inverse_of: :messages
	)

	belongs_to(
		:sender,
		class_name: "User",
		foreign_key: :sender_id,
		primary_key: :id
	)

	belongs_to(
		:recipient,
		class_name: "User",
		foreign_key: :recipient_id,
		primary_key: :id
	)

end
