class PlacesController < ApplicationController

  def home
    authorize Place
  end

  def index
    @places = policy_scope(Place)
    @places = @places.where(user: current_user)
  end
  def show
    @place = Place.find(params[:id])
    @booking = Booking.new

    @bookings = Booking.where(user: current_user)
    @events = []
    @bookings.each do |booking|
    @events << {title:  "#{booking.user.first_name} #{booking.user.last_name}", start: booking.start_time.iso8601, end: booking.end_time.iso8601, allDay: false}


    end
    authorize @place
  end

  def new
    @place = Place.new
    authorize @place
  end
  def create
    @place = current_user.places.build(place_params)
    authorize @place
    if @place.save
      PlaceMailer.creation_confirmation(@place).deliver_now
      redirect_to places_path
    else
      render :new
    end
  end

  def edit
    @place = Place.find(params[:id])
    @whitelists = @place.whitelists
    @whitelist = Whitelist.new
    authorize @place
  end

  def update
    @place = Place.find(params[:id])
    authorize @place
    @place.update(place_params)
    redirect_to edit_place_path(@place)
  end

  def destroy
    @place = Place.find(params[:id])
    authorize @place
    @place.destroy
  end

  private

  def place_params
    params.require(:place).permit(:address, :name, :user, :photo)
  end

end
