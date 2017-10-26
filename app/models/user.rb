class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #mailboxer
  acts_as_messageable
  def mailboxer_email(object)
      return "define_email@on_your.model"
  end
  #attachinary
  has_attachment :photo

  has_many :skills, dependent: :destroy
  has_many :spaces, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :user_reviews, dependent: :destroy

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
