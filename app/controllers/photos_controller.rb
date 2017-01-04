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
    @photo = location.photos.build(permit_photo)
    if @photo.save
      flash[:succes] = "You have succesfully added a Photo!"
      redirect_to location_path(@photo.location) #aqui en show debiera empezar a hacer lo de las locations
    else
      flash[:error] = "Error: " + @photo.errors.full_messages[0] + "."
      redirect_to location_path(@photo.location)
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @location = @photo.location
    if @photo.destroy    
      flash[:success] = "You have succesfully deleted the Photo"
      redirect_to location_path(@location)
    else
      flash[:error] = @photo.errors.full_messages[0]
      redirect_to location_path(@location)
    end
  end

  private

    def permit_photo
      params.require(:photo).permit(:image,:description, :date)
    end

end
