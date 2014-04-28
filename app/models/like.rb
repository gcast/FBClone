class Like < ActiveRecord::Base

	validates :likeable, :liker_id, presence: true
	validates :liker_id, :uniqueness => {:scope => :likeable}

	belongs_to :likeable, polymorphic: true

	belongs_to(
		:liker, 
		class_name: "User",
		foreign_key: :liker_id,
		primary_key: :id
	)


end
