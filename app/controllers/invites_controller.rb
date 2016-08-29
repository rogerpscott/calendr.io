class InvitesController < ApplicationController
  def show
    @user = current_user
    @place = Place.friendly.find(params[:id])
    authorize @place
  end

  def update
    skip_authorization
    @place = Place.friendly.find(params[:id])
    PlaceMailer.ask_invitation(@place, current_user).deliver_now
    redirect_to root_path
  end
end
