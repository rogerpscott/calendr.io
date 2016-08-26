class WhitelistMailer < ApplicationMailer
  def invitation(whitelist)
    @whitelist = whitelist
    @place = whitelist.place
    mail(to: @whitelist.email,
      subject: "#{@place.user.first_name} #{@place.user.last_name} invited you to join #{@place.name}."
    )
  end
end
