class Comment < ActiveRecord::Base

	validates :comment, :author_id, presence: true
	
	belongs_to :commentable, polymorphic: true

	belongs_to(
		:author, 
		class_name: "User",
		foreign_key: :author_id,
		primary_key: :id
	)

end
