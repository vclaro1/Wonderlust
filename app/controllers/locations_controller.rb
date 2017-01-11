class LocationsController < ApplicationController

  def new
  	@location = Location.new
    @trip = Trip.find(params[:trip_id])
    @location.interests.build 
    @photos = @location.photos.build
    @tip = @location.tips.build
  end

  def index
  end

  def show
    @location = Location.find(params[:id])
    @others = Location.where(:latitude => @location.latitude, :longitude => @location.longitude)
    @trip = Trip.find(@location.trip_id)
    @photo = Photo.new
    @tip = Tip.new
    @json = {:lat => @location.latitude, :lng => @location.longitude }.to_json
    @hash = Gmaps4rails.build_markers(@location.tips) do |user, marker|
      aux = {:url  => "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png", :width =>  32, :height => 32}
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.description
      marker.picture  aux
    end
  end

  def create
    trip = Trip.find(params[:trip_id])
  	@location = trip.locations.build(permit_location)
  	if @location.save
  		flash[:success] = "You have succesfully created a new Location!"
  		redirect_to [trip, @location]
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
  		params.require(:location).permit(:address,:country, :days, :order, :travel_mode, photos_attributes: [:id, :_destroy, :description, :date, :image], tips_attributes: [:name, :description, :date, :longitude, :latitude]) #ojo que hay que ver siesque order realmente sirve
  	end
    
end
