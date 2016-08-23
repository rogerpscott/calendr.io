class WhitelistsController < ApplicationController

  def index
    # @user = current_user
    # @whitelist = Whitelist.where(place_id: Places.current_user)
  end

  def create
    @place = Place.find(params[:place_id])
    @whitelist = Whitelist.new(params_whitelist)
    @whitelist.place = @place
    if @whitelist.save
      redirect_to edit_place_path(@place)
    else
      render 'places/edit'
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @whitelist = Whitelist.find(params[:id])
    @whitelist.destroy
    redirect_to edit_place_path(@place)
  end

   def params_whitelist
    params.require(:whitelist).permit(:email)
  end

end
