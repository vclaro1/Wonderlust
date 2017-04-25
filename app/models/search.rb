class Search < ActiveRecord::Base

	def search_locations
		contry = nil
		if name != "" and continent != ""
			contry = Location.where({address: name, country: continent}) 
		elsif name != ""
			contry = Location.where({address: name}) 
		elsif continent != ""
			contry = Location.where({country: continent}) 	
		end
		if not contry.nil? and interests != ""
			contry = search_interest(contry)
		end
		return contry
	end

	def search_interest(contry)
		clone = contry.to_a.clone
		arr = interests.split(",")
		contry.each do |locs|
				if not locs.tips.where({name: arr}).any?
					clone.delete(locs)
				end
		end
		return clone
	end
end
