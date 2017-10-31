class UserReview < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true

  belongs_to :user
  belongs_to :booking
end
