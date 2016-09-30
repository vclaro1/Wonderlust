class InterestController < ApplicationController
  def new
  	@interest = Interest.new
  end

  def create
  	@interest = current_location.interests.build(params[:interest])
  	if @interest.save
  		flash[:succes] = "You have succesfully added your Interest!"
  		redirect_to location_path(@interest.location) #aqui en show debiera empezar a hacer lo de las locations
  	else
  		flash[:error] = @interest.errors.full_messages
  		redirect_to interest_new_path
  	end
  end

  private
  
  	def permit_interest
  		params.require(:interest).permit(:name)
  	end
end
