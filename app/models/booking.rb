class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :space
  has_many :user_reviews, dependent: :destroy

  validates :status, presence: true
end
