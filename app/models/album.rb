class Album < ActiveRecord::Base

	validates :owner_id, :name, presence: true

	has_many :photos, as: :imageable, dependent: :destroy

	belongs_to(
		:owner, 
		class_name: "User",
		foreign_key: :owner_id,
		primary_key: :id
	)

end
