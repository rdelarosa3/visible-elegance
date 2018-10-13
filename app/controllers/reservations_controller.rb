class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:show, :edit, :update, :destroy]
  include UsersHelper

  def index
    # checks if user admin or logged in

    @stylist = User.stylist
    if params[:reservation]
      
      @reservations = Reservation.includes(:user).where(nil).all
      if params[:reservation][:date_start] != "" || params[:reservation][:date_end] != ""
        @reservations = @reservations.date_range(params[:reservation][:date_start],params[:reservation][:date_end]).all 
      end
      if params[:reservation][:stylist] != ""
        @reservations = @reservations.stylist_name(params[:reservation][:stylist]).all 
      end
      if params[:reservation][:service] != ""
        @reservations = @reservations.service_name(params[:reservation][:service]).all 
      end
      @reservations.order(reservation_date: :desc)
      respond_to do |format|    
        format.html {render :index }
        format.js
      end
    else
    @reservations = Reservation.all.order(reservation_date: :desc)
    end
  end

  def new
    @reservation = Reservation.new
    @stylist = User.stylist
  end

  def edit
  end


  def create
    @stylist = User.stylist
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|

      if @reservation.save
        length = Service.find(params[:reservation][:service_id]).length
        @reservation.end_time = @reservation.reservation_time + (length * 60)
        if @reservation.save # format.js { render :file => "/layouts/application.js"}
          flash.now.notice = "Reservation request submitted."
          format.html { redirect_to current_user, notice: 'Reservation request submitted.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          flash.now.notice = "Reservation could not be processed. Try again."
          @reservation.destroy
          format.js { render :file => "/layouts/application.js"}
        end
      else
        flash.now.notice = @reservation.errors[:overlapping_appointments].first || @reservation.errors[:stylist_id].first || @reservation.errors[:verify_time].first
        format.js { render :file => "/layouts/application.js"}
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    unless current_user.operator? || current_user.admin?
      redirect_to new_reservation_path, notice: 'Reservation for current service already exists.'
    end
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_url, notice: 'Reservation was successfully updated.' }
        # format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def status_change
    @reservation = Reservation.find(params[:id])
    if @reservation.pending?
      @reservation.status = 'approved'
      @reservation.save
      redirect_to reservations_url, notice: 'Reservation was approved.'
    else
      @reservation.status = 'pending'
      @reservation.save
      redirect_to reservations_url, notice: 'Status changed to pending.'
    end

  end

  private
      # to keep users other than admin from accessing
    def authorize
        redirect_to root_path, alert: 'You must be admin to access this page.' if current_user.nil? || !current_user.admin?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :service_id, :reservation_date, :reservation_time, :notes, :stylist_id, :status)
    end
end
