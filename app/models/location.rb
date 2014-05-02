class Location < ActiveRecord::Base

	validates :long, :lat, :locationable, presence: true

	belongs_to :locationable, polymorphic: true

end
