class TripsController < ApplicationController
  before_action :find_trip, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_activities, only: [:index, :show, :new, :edit]
  respond_to :html, :js

  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end
  def new
  	@trip = Trip.new
    @location = @trip.locations.build
  end

  def edit 
  end
  def my_trips
    @user = current_user
    if @user
      following_ids = current_user.following_users.map(&:id)
      @trips = Trip.where(user_id: following_ids).order("created_at DESC").paginate(page: params[:page])
    end  
  end

  def update 
    if @trip.update(permit_trip)
      redirect_to trip_path(@trip), notice: "Trip was succesfully updated!"
    else
      render 'edit'
    end
  end

  def add_location
    @trip = Trip.find(params[:trip_id])
    redirect_to @trip
  end

  def index
    @user = current_user
    if @user
  	  @trips = Trip.all.order("created_at DESC")
    end
  end

  def show
    @user = current_user
  	@locations = @trip.locations
    @location = Location.new
    @trips = @user.trips
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
    if @trip.destroy    
      flash[:success] = "You have succesfully deleted the Trip!"
      redirect_to trips_path
    else
      flash[:error] = @trip.errors.full_messages
      redirect_to trips_path
    end
  end

  private
  

  def find_trip
    @trip = Trip.find(params[:id])
  end
  def permit_trip
  	params.require(:trip).permit(:name, :date_start,:date_end,:rating, :budget, :image, :id, locations_attributes: [:address, :_destroy, :country, :days, :travel_mode])
  end
end