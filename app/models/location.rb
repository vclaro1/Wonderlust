class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :interests, :dependent => :destroy
	has_many :tips, :dependent => :destroy
	has_many :photos, :dependent => :destroy
	geocoded_by :full_address
	after_validation :geocode
	accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
	accepts_nested_attributes_for :tips, allow_destroy: true
	accepts_nested_attributes_for :interests, allow_destroy: true
	def full_address
		[country, address].compact.join(", ")
	end
	def new_photo_attributes=(photo_attributes)
		photo_attributes.each do |attributes|
			photos.build(attributes)
		end
	end
	def new_tip_attributes=(tip_attributes)
		tip_attributes.each do |attributes|
			tips.build(attributes)
		end
	end
end
