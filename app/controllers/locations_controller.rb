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
    @user = current_user
    @location = Location.find(params[:id])
    @others = Location.where(:latitude => @location.latitude, :longitude => @location.longitude)
    @interests = Tip.uniq.pluck(:name)
    @trips = @user.trips
    @photo = Photo.new
    @tip = Tip.new
    @json = {:lat => @location.latitude, :lng => @location.longitude }.to_json
    @hash = Gmaps4rails.build_markers(@location.tips) do |tip, marker| 
      marker.lat tip.latitude
      marker.lng tip.longitude
      marker.infowindow render_to_string(:partial => "/tips/infowindow", :locals => {:tip => tip, :user => current_user, :trip => @trip}) #:locals son las variables a usar en el partial, en el partial usar sender. 
      marker.picture({:url  => "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png", :width =>  32, :height => 32})
    end
  end

  def add_tip
    trip = Trip.find(params[:trip_id])
    tip = Tip.find(params[:tip])
    long = tip.location.longitude
    puts long.inspect
    lat = tip.location.latitude
    @new_tip = Tip.new
    @new_tip = tip.dup
    puts @new_tip.inspect
    if trip.locations.any?{|location| location.longitude = long && location.latitude = lat}
      trip.locations.where(longitude: long).find_each do |loc|
        @new_tip.location_id = loc.id
      end
      @new_tip.save
      flash[:success] = "You have succesfully added this tip to your trip"
      redirect_to :back
    else 
      @new_location = Location.new
      @new_location = tip.location.dup
      @new_location.trip_id = trip.id
      puts @new_location.inspect
      @new_location.save
      @new_tip.location_id = @new_location.id
      puts @new_tip.inspect
      @new_tip.save
      flash[:success] = "You have succesfully added this tip to your trip"
      redirect_to @new_location
    end
    #Por si te sirve esta funcion de abajo te muestra todos los atributos de la variable new_location para ver si lo estay pasando bien.
    #La use caleta

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
