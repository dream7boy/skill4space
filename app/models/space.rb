class Space < ApplicationRecord
  validates :name, presence: true
  validates :photos, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :category, presence: true
  validates :required_skill, presence: true
  # validates :daily_price, numericality: { only_integer: true, greater_than: 0 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attachments :photos, maximum: 5

  has_many :bookings, dependent: :destroy
  belongs_to :user
end
