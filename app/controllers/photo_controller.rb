class PhotoController < ApplicationController
  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = current_location.photos.build(params[:photo])
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
