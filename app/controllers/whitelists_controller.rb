class WhitelistsController < ApplicationController

  def index
    skip_policy_scope
    @user = current_user
    @place = Place.find(params[:place_id])
    @whitelist = Whitelist.new(email: params[:invite_email])
  end

  def create
    @place = Place.find(params[:place_id])
    @whitelist = Whitelist.new(params_whitelist)
    @whitelist.place = @place
    authorize @whitelist
    if @whitelist.save
      WhitelistMailer.invitation(@whitelist).deliver_now
      redirect_to place_whitelists_path(@place)
    else
      redirect_to place_whitelists_path(@place), alert: "Error"
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @whitelist = Whitelist.find(params[:id])
    authorize @whitelist
    @whitelist.destroy
    redirect_to place_whitelists_path(@place)
  end

   def params_whitelist
    params.require(:whitelist).permit(:email)
  end

end
