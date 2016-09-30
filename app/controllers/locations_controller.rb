class LocationsController < ApplicationController
  def new
  	@location = Location.new
  end

  def index
  end

  def show
  	@location = Location.find(params[:id])
  end

  def create
  	@location = current_trip.locations.build(permit_location)
  	if @location.save
  		flash[:success] = "You have succesfully created a new Location!"
  		redirect_to trip_path(@location.trip)
  	else	
  		flash[:error] = @location.errors.full_messages
  		redirect_to_to locations_new_path
  	end
  end

  def destroy
    @location = Location.find(params[:id])
    @trip = @location.trip
    if @location.destroy    
      flash[:success] = "You have succesfully deleted the Location!"
      redirect_to trip_path(@trip)
    else
      flash[:error] = @location.errors.full_messages
      redirect_to trip_path(@trip)
    end
  end

  private
  
  	def permit_location
  		params.require(:location).permit(:name, :lat, :long, :days, :order, :travel_mode) #ojo que hay que ver siesque order realmente sirve
  	end
end
