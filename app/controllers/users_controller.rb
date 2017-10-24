class UsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :bookings, :listings]

  def show
  end

  def edit
  end

  def update
    @user.update(users_params)
    redirect_to profile_path
    flash[:notice] = "Your profile was edited"
  end

  def listings
  end

  def bookings
    @spaces = @user.bookings.map do |booking|
      Space.find(booking.space_id)
    end
  end

  private

  def users_params
    params.require(:user).permit(:email, :name, :address)
  end

  def set_user
    @user = current_user
  end
end
