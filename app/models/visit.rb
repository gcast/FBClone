class Visit < ActiveRecord::Base

	validates :ip_address, presence: true

end
