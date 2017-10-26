class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attachment :photo

  has_many :skills, dependent: :destroy
  has_many :spaces, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
end
