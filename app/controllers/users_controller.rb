class UsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :profile, :bookings, :listings]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user.update(users_params)
    redirect_to profile_path
    flash[:notice] = "Your profile was edited"
  end

  def profile
  end

  def listings
  end

  def bookings
  end

  private

  def users_params
    params.require(:user).permit(:email, :name, :address)
  end

  def set_user
    @user = current_user
  end
end
