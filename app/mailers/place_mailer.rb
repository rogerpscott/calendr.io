class PlaceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.place_mailer.creation_confirmation.subject
  #
  def creation_confirmation(place)
    @place = place
    @user = place.user

    mail(to: @place.user.email,
      subject: "Your place #{@place.name} was created!"
    )
  end
end
