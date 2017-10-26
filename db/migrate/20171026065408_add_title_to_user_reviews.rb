class AddTitleToUserReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :user_reviews, :title, :string
  end
end
