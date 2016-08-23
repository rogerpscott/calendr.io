class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end


  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @user = current_user

    @booking = Booking.new(booking_params)
    @booking.place = @place
    @booking.user = @user

    if @booking.save
      BookingMailer.creation_confirmation(@booking).deliver_now
      redirect_to  edit_place_booking_path(@place, @booking)
    else
      render 'bookings/edit'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end
  def update
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    # on doit autoriser le champs de l'élément caché place_id
    params.require(:booking).permit(:start_time, :end_time, :place_id)
  end
end
