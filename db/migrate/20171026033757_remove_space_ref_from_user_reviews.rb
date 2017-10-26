class RemoveSpaceRefFromUserReviews < ActiveRecord::Migration[5.1]
  def change
    remove_reference :user_reviews, :space, foreign_key: true
  end
end
