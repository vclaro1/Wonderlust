class SearchSuggestionsController < ApplicationController

	def index
		@users = User.search(params[:term]).limit(4)
		@resp = @users.map do |u|
			 { :id => u.id, :name => u.name, :email => u.email, :image_url => u.image.url(:thumb) , :trips => u.trips.length, :user_since => u.created_at.strftime('%B %Y')}
		end
    	render json: @resp
	end

end
