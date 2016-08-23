class PlacesController < ApplicationController

  def home
  end

  def index
    @places = current_user.places
    @places = policy_scope(Place)
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new
    authorize @place
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    authorize @place
    @place.save
    redirect_to places_path
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    @place.update(place_params)
    redirect_to places_path
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
