class StampsController < ApplicationController
before_action :set_stamp, only: [:edit, :update, :destroy]
include UsersHelper
  def stamp


    user_id = params[:user_id]
    @user = User.find(user_id)
    @stamp = Stamp.new(user_id: user_id, stamper_id: current_user.id)

    respond_to do |format|
      if @stamp.save
        flash.now.notice = 'Card Stamped'
        format.js { render :file => "/layouts/application.js"}
      else
        flash.now.notice = 'Error in Card stamped'
        format.js { render :file => "/layouts/application.js"}
      end
    end
  end

  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        format.html { redirect_to @stamp, notice: 'Stamp was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamp }
      else
        format.html { render :edit }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def reset_loyalty
    user_id = params[:user_id]
    @user = User.find(user_id)
    respond_to do |format|
      @user.stamps.delete_all
        flash.now.notice = 'Loyalty Card Redeemed. Heres a new Card' 
        format.js { render :file => "/layouts/application.js"}
    end
  end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamp
      @stamp = Stamp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamp_params
      params.require(:stamp).permit(:user_id)
    end
end