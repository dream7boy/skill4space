class AddFieldToUserReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :user_reviews, :reviewer_name, :string
  end
end
