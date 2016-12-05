class PhotosController < ApplicationController
  def new
    @photo = Photo.new
    @location = Location.find(params[:location_id])
  end

  def show
    @location = Location.find(params[:location_id])
    @photo = Photo.find(params[:id])
  end

  def create
    location = Location.find(params[:location_id])
    @photo = location.photos.build()
    if @photo.save
      flash[:succes] = "You have succesfully added your Interest!"
      redirect_to location_path(@photo.location) #aqui en show debiera empezar a hacer lo de las locations
    else
      flash[:error] = @photo.errors.full_messages
      redirect_to photo_new_path
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @location = @photo.location
    if @photo.destroy    
      flash[:success] = "You have succesfully deleted the Photo"
      redirect_to location_path(@location)
    else
      flash[:error] = @photo.errors.full_messages
      redirect_to location_path(@location)
    end
  end

  private

    def permit_photo
      params.require(:photo).permit(:description, :date)
    end

end
