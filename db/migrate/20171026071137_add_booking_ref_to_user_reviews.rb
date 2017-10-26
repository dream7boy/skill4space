class AddBookingRefToUserReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_reviews, :booking, foreign_key: true
  end
end
