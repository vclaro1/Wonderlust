class Search < ActiveRecord::Base

	def search_locations_address
		contry = Location.where(["address LIKE ?", "%#{name}%"]) if name.present?
		if not contry.nil? and interests.present?
			contry = contry.to_a
			contry.each do |locs|
					if not locs.interests.where(["name LIKE ?", "%#{interests}%"]).any?
						contry.delete(locs)	
					end
			end	
		end
		return contry
	end

	def search_locations_country
		contry = Location.where(["country LIKE ?", "%#{continent}%"]) if continent.present?
		if not contry.nil? and interests.present?
			contry = contry.to_a
			contry.each do |locs|
					if not locs.interests.where(["name LIKE ?", "%#{interests}%"]).any? or not locs.interests.where(["name LIKE ?", nil]).any?
						contry.delete(locs)	
					end
			end	
		end
		return contry
	end
end
