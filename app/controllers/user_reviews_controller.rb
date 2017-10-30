class UserReviewsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    @space = @booking.space
    @user = User.find(params[:user_id])
    @user_review = @user.user_reviews.build({ booking_id: @booking.id })
  end

  def create
    @user = User.find(params[:user_id])
    @user_review = @user.user_reviews.build(user_review_params)
    @user_review.reviewer_name = current_user.name

    if @user_review.save
      redirect_to user_path(@user)
    else
      # render "new"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @user_review = UserReview.find(params[:id])
    @user_review.destroy
    redirect_back(fallback_location: root_path)
  end

    # @booking = Booking.find(params[:id])
    # @booking.destroy
    # redirect_to bookings_path
    # flash[:notice] = "Your booking has been deleted"

  private

  def user_review_params
    params.require(:user_review).permit(:title, :content, :rating, :booking_id)
  end

end
