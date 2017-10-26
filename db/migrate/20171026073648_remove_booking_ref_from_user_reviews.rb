class RemoveBookingRefFromUserReviews < ActiveRecord::Migration[5.1]
  def change
    remove_reference :user_reviews, :booking, foreign_key: true
  end
end
