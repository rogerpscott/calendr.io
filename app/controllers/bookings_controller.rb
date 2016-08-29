class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
    @bookings = @bookings.where(user: current_user).order(:start_time)
  end


  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @user = current_user

    @booking = Booking.new(booking_params)
    @booking.place = @place
    @booking.user = @user
    authorize @booking
    if @booking.start_time < @booking.end_time
      if @booking.save
        BookingMailer.creation_confirmation(@booking).deliver_now
        redirect_to bookings_path
      else
        redirect_to place_path(@place), alert: "#{@place.name} is not available at that time. Please check the calendar."
      end
    else
      redirect_to place_path(@place), alert: "Please choose a start time that is before the end time"
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
