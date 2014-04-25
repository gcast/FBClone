class Photo < ActiveRecord::Base

	belongs_to :imageable, polymorphic: true
	has_many :comments, as: :commentable
	has_many :notifications, as: :notifiable, dependent: :destroy

  	has_attached_file :file, :styles => {
    	:big => "600x600",
    	:med => "300x300",
    	:thumb => "100x100"
    	#Why doesn't it get smaller?
  	}

  	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

    def self.default_photo_url
      return "http://fit.physics.ucdavis.edu/lib/exe/fetch.php?cache=cache&media=shared:no-avatar.jpg"
    end

    def self.default_cover_photo_url
      return "http://www.thepinesgolf.org.nz/grey%20background.jpg"
    end

end
