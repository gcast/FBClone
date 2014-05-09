class MessageThread < ActiveRecord::Base

	validates :user_one, :user_two, presence: true

	belongs_to(
		:first_user,
		class_name: "User",
		foreign_key: :user_one,
		primary_key: :id
	)

	belongs_to(
		:second_user,
		class_name: "User",
		foreign_key: :user_two,
		primary_key: :id
	)

	has_many(
		:messages,
		class_name: "Message",
		foreign_key: :thread_id,
		primary_key: :id,
		inverse_of: :message_thread,
		dependent: :destroy
	)

	def self.find_thread_with_user(current_user, user2_id)
		threadOne = current_user.message_threads_as_one.where("user_two = ?", user2_id).first
		threadTwo = current_user.message_threads_as_two.where("user_one = ?", user2_id).first

		threadOne || threadTwo
	end

end
