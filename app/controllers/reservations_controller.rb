class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  include UsersHelper
  # GET /reservations
  # GET /reservations.json
  def index
    validate_user
    @stylist = User.stylist
    if params[:reservation]
      
      @reservations = Reservation.where(nil).all
      if params[:reservation][:date_start] != "" || params[:reservation][:date_end] != ""
        @reservations = @reservations.date_range(params[:reservation][:date_start],params[:reservation][:date_end]).all 
      end
      if params[:reservation][:stylist] != ""
        @reservations = @reservations.stylist_name(params[:reservation][:stylist]).all 
      end
      if params[:reservation][:service] != ""
        @reservations = @reservations.service_name(params[:reservation][:service]).all 
      end
      respond_to do |format|    
        format.html {render :index }
        format.js
      end
    else
    @reservations = Reservation.all
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
 
  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @stylist = User.stylist
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @stylist = User.stylist
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|

      if @reservation.save
        format.html { redirect_to new_reservation_path, notice: 'Reservation request submitted.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.js { render :file => "/layouts/application.js"}
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validate_user
     if session[:user_id] != nil
      unless current_user.role == 'admin'
        redirect_to root_path
      end
     else 
      redirect_to root_path
    end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :service_id, :reservation_date, :reservation_time, :notes, :stylist_id)
    end
end
