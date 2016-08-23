class PlacesController < ApplicationController

  def index
    @user = current_user
    @places = @user.places
  end
  def show
    @place = Place.find(params[:id])
    @booking = Booking.new

  end

  def new
    @place = Place.new
  end
  def create
    @place = Place.new(place_params)
    @place.user = current_user
    @place.save
    redirect_to places_path
  end

  def edit
    @place = Place.find(params[:id])
    @whitelists = @place.whitelists
    @whitelist = Whitelist.new
  end

  def update
    @place = Place.find(params[:id])
    @place.update(place_params)
    redirect_to edit_place_path(@place)
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
  end

  private

  def place_params
    params.require(:place).permit(:address, :name, :user)
  end

end
