class Space < ApplicationRecord
  validates :name, presence: true
  validates :daily_price, numericality: { only_integer: true, greater_than: 0 }
end
