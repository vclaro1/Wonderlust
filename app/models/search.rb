class Search < ActiveRecord::Base

	def search_locations_address
		contry = Location.where(["address LIKE ?", "%#{name}%"]) if name.present?
		if not contry.nil? and interests.present?
			contry = contry.to_a
			clone = contry.clone
			contry.each do |locs|
					if not locs.interests.where(["name LIKE ?", "%#{interests}%"]).any? 
						clone.delete(locs)	
					end
			end
			contry = clone	
		end
		return contry
	end

	def search_locations_country
		contry = Location.where(["country LIKE ?", "%#{continent}%"]) if continent.present?
		if not contry.nil? and interests.present?
			contry = contry.to_a
			clone = contry.clone
			contry.each do |locs|
					if not locs.interests.where(["name LIKE ?", "%#{interests}%"]).any? 
						clone.delete(locs)	
					end
			end
			contry = clone	
		end
		return contry
	end
end
