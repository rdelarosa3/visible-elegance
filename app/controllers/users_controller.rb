class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:show, :edit, :update, :destroy]
  include UsersHelper

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  
  def edit

  end


  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to edit_user_path(@user), notice: 'Account created. Please confirm or edit details"' }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now.alert = "Please make sure you are using a valid email and password and try again."
        format.js { render :file => "/layouts/application.js"}
        # format.json { render json: @user.errors, status: :unprocessable_entity }    

      end
    end
  end


  def update

      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'Account was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use to validate only authorized user is viewing page
    def validate_user
      unless logged_in? && (current_user.admin? || current_user.id == @user.id)
        redirect_to root_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :birthday, :password, :password_confirmation, :gender, :avatar, :phone_number, :notes, :remove_avatar, :facebook, :instagram, :linkedin, :title_id)
    end
end
