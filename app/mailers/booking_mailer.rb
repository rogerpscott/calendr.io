class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.creation_confirmation.subject
  #
  def creation_confirmation(booking)
    @booking = booking
    @place = booking.place
    @user = booking.place.user

    mail(to: @booking.place.user.email,
      subject: "Your place #{@place.name} received a booking!"
    )
  end
end
