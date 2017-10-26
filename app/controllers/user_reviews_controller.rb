class UserReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user_review = @user.user_reviews.build
  end

  def create
    @user = User.find(params[:user_id])
    @user_review = @user.user_reviews.build(user_review_params)
    @user_review.reviewer_name = current_user.name

    if @user_review.save
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  private

  def user_review_params
    params.require(:user_review).permit(:title, :content, :rating)
  end

end
