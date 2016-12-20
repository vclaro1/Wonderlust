class TipsController < ApplicationController
  def new
  	@tip = Tip.new
    @location = Location.find(params[:location_id])
  end

  def show
    @location = Location.find(params[:location_id])
  	@tip = Tip.find(params[:id])
  end

  def create
    location = Location.find(params[:location_id])
  	@tip = location.tips.build(permit_tip)
  	if @tip.save
  		flash[:succes] = "You have succesfully added your Interest!"
  		redirect_to location_path(@tip.location) #aqui en show debiera empezar a hacer lo de las locations
  	else
  		flash[:error] = @tip.errors.full_messages
  		redirect_to tip_new_path
  	end
  end

  def destroy
    @tip = Tip.find(params[:id])
    @location = @tip.location
    if @tip.destroy    
      flash[:success] = "You have succesfully deleted the Tip"
      redirect_to location_path(@location)
    else
      flash[:error] = @tip.errors.full_messages
      redirect_to location_path(@location)
    end
  end

  private

  	def permit_tip
  		params.require(:tip).permit(:name, :date, :description)
  	end
end
