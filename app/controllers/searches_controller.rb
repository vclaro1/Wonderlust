class SearchesController < ApplicationController
  
	def new
		@search = Search.new
		@interests = Tip.uniq.pluck(:name)
	end

	def create
		@search = Search.create(search_params)
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
		if @search.search_locations.nil?
			string = "Location"
			if @search.tipo != "loc" 
				string = "Trip"	
			end
			redirect_to new_search_path, notice: "No results for your " + string + " Search."
		end
	end

	private
		def search_params
			params.require(:search).permit(:name, :continent, :interests, :tipo)
		end
end
