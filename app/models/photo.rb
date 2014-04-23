class Photo < ActiveRecord::Base

	belongs_to :imageable, polymorphic: true
	has_many :comments, as: :commentable
	has_many :notifications, as: :notifiable, dependent: :destroy

  	has_attached_file :file, :styles => {
    	:big => "600x600",
    	:med => "300x300",
    	:thumb => "100x100"
  	}

  	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

end
