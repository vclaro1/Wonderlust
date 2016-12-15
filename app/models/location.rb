class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :interests, :dependent => :destroy
	has_many :tips, :dependent => :destroy
	has_many :photos, :dependent => :destroy
	geocoded_by :full_address
	after_validation :geocode

	def full_address
		[country, address].compact.join(", ")
	end
end
