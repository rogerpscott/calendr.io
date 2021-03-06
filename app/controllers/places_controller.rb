class PlacesController < ApplicationController

  def home
    authorize Place
    render :layout => 'home_layout'
  end

  def index
    @places = policy_scope(Place)
    @places_whitelisted = @places.where(id: Whitelist.where(email: current_user.email).pluck(:place_id))
    @places = @places.where(user: current_user)
  end
  def show
    @place = Place.friendly.find(params[:friendly_id])
    authorize @place
    @user = current_user
    if @place.whitelists.find_by_email(@user.email) || @place.user == @user
      @booking = Booking.new
      @bookings = Booking.where(place: @place)
      @hash = Gmaps4rails.build_markers([@place]) do |place, marker|
        marker.lat place.latitude
        marker.lng place.longitude
      end
      @events = []
      @bookings.each do |booking|
        @events << {title:  "#{booking.user.first_name} #{booking.user.last_name}", start: booking.start_time.iso8601, end: booking.end_time.iso8601, allDay: false}
      end
    else
      redirect_to invite_path(@place)
    end
  end

  def new
    @place = Place.new
    authorize @place
    @place.whitelists.build
  end
  def create
    @place = current_user.places.build(place_params)
    authorize @place
    if @place.save
      PlaceMailer.creation_confirmation(@place).deliver_now
      redirect_to friendly_place_path(@place)
    else
      render :new
    end
  end

  def edit
    @place = Place.friendly.find(params[:id])
    @whitelists = @place.whitelists
    @whitelist = Whitelist.new
    authorize @place
  end

  def update
    @place = Place.friendly.find(params[:id])
    authorize @place
    if @place.update(place_params)
    redirect_to friendly_place_path(@place)
    else
    render :edit
    end
  end

  def destroy
    @place = Place.friendly.find(params[:id])
    authorize @place
    @place.destroy
    redirect_to places_path, notice: "Your place has been successfully cancelled"
  end

  private

  def place_params
    params.require(:place).permit(:latitude, :longitude, :address, :name, :description, :user, :photo, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, whitelists_attributes: [:id, :email, :_destroy])
  end

end
