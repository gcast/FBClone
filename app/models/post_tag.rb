class PostTag < ActiveRecord::Base

	validates :post, :tagged_user_id, presence: true
	validates :post_id, uniqueness: { scope: :tagged_user_id }

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

end
