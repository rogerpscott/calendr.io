class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
    @bookings = @bookings.where(user: current_user).order(:start_time).reverse_order
  end


  def new
  end

  def create
    @place = Place.friendly.find(params[:place_id])
    @user = current_user

    @booking = Booking.new(booking_params)
    @booking.place = @place
    @booking.user = @user
    authorize @booking

    if @booking.save
      BookingMailer.creation_confirmation(@booking).deliver_now
      redirect_to bookings_path
    else
      redirect_to place_path(@place)
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end
  def update
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    # on doit autoriser le champs de l'élément caché place_id
    params.require(:booking).permit(:start_time, :end_time, :place_id)
  end
end
