class Location < ActiveRecord::Base

	require 'net/http'

	before_save :reverse_geocode

	validates :long, :lat, :locationable, presence: true

	belongs_to :locationable, polymorphic: true

	def reverse_geocode
		address = {}

		url_string = "http://api.tiles.mapbox.com/v3/gavcastro.i4mcl7e7/geocode/#{self.long},#{self.lat}.json"
		url = URI.parse(url_string)

		req = Net::HTTP::Get.new(url.path)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}
		
		location_hash = {}
		results = JSON.parse(res.body)
		address = results["results"][0]

		address.each do |address_hash|
			location_hash[address_hash["type"]] = address_hash["name"]
		end

		self.location_string = location_hash.to_json
	end

end
