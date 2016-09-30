class TripsController < ApplicationController
  def new
  	@trip = Trip.new
  end

  def index
    if current_user
  	 @trips = current_user.trips
    end
  end

  def show
  	@trip = Trip.find(params[:id])
  	@locations = @trip.locations
  end

  def create
  	@trip = current_user.trips.build(permit_trip)
  	if @trip.save
  		flash[:succes] = "You have succesfully created a new Trip!"
  		redirect_to trip_path(@trip) #aqui en show debiera empezar a hacer lo de las locations
  	else
  		flash[:error] = @trip.errors.full_messages
  		redirect_to new_trip_path
  	end
  end

  def destroy
    @trip = Trip.find(params[:id])
    if @trip.destroy    
      flash[:success] = "You have succesfully deleted the Trip!"
      redirect_to trips_path
    else
      flash[:error] = @trip.errors.full_messages
      redirect_to trips_path
    end
  end

  private
  	def permit_trip
  		params.require(:trip).permit(:name, :date_start,:date_end,:rating, :budget)
  	end
end