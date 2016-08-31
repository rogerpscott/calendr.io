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
    if @booking.start_time < DateTime.now
      redirect_to place_path(@place), alert: "You cannot book a date in the past"
    elsif @booking.start_time > @booking.end_time
      redirect_to place_path(@place), alert: "Please choose a start time that is before the end time"
    elsif ( get_days_of_booking(@booking) & @place.non_available_day ).any?
      redirect_to place_path(@place), alert: "#{@place.name} is not available during these days. Please check the calendar."
    elsif @booking.save
      BookingMailer.creation_confirmation(@booking).deliver_now
      redirect_to bookings_path
    else
      redirect_to place_path(@place), alert: "#{@place.name} is not available at that time. Please check the calendar."
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

  def get_days_of_booking(booking)
    js = booking.start_time.strftime("%j").to_i
    je = booking.end_time.strftime("%j").to_i
    s = booking.start_time.strftime("%w").to_i
    e = booking.end_time.strftime("%w").to_i
    if je - js > 5
      return (0..6).to_a
    elsif s <= e
      return (s..e).to_a
    else
      return (0..6).to_a.reject { |i| ((e + 1)...s).include? i}
    end
  end
end
