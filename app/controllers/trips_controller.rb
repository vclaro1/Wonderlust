class TripsController < ApplicationController
  before_action :find_trip, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_activities, only: [:index, :show, :new, :edit]
  
  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end
  def new
  	@trip = Trip.new
  end

  def edit 
  end

  def update 
    if @trip.update(permit_trip)
      redirect_to trip_path(@trip), notice: "Trip was succesfully updated!"
    else
      render 'edit'
    end
  end

  def upvote
    @trip.upvote_by current_user
    redirect_to :back
  end


  def index
    @user = current_user
    if @user
  	  @trips = Trip.all.order("created_at DESC")
    end
  end

  def show
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
  	params.require(:trip).permit(:name, :date_start,:date_end,:rating, :budget, :image)
  end
end