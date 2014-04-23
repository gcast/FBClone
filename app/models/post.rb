class Post < ActiveRecord::Base

	validates :body, :author_id, presence: true

	has_many :comments, as: :commentable

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

end
