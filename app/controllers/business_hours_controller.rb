class BusinessHoursController < ApplicationController
  before_action :set_business_hour, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:show, :edit, :update, :destroy]
  
  def new
    @business_hour = BusinessHour.new
  end

  def create
    @business_hour = BusinessHour.new(business_hour_params)

    respond_to do |format|
      if @business_hour.save
        format.html { redirect_to @business_hour, notice: 'Business hour was successfully created.' }
        format.json { render :show, status: :created, location: @business_hour }
      else
        format.html { render :new }
        format.json { render json: @business_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @business_hour.update(business_hour_params)
        format.html { redirect_to @business_hour, notice: 'Business hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_hour }
      else
        format.html { render :edit }
        format.json { render json: @business_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @business_hour.destroy
    respond_to do |format|
      format.html { redirect_to business_hours_url, notice: 'Business hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def authorize
      redirect_to root_path, alert: 'You must be admin to access this page.' if current_user.nil? || !current_user.admin?
    end  
    # Use callbacks to share common setup or constraints between actions.
    def set_business_hour
      @business_hour = BusinessHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_hour_params
      params.require(:business_hour).permit(:business_id, :day, :open_time, :close_time)
    end
end
