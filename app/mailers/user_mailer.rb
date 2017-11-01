class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to skill4.space')

    # @greeting = "Hi"

    # mail to: "to@example.org"
  end

  def get_message(sender, receiver, conversation)
    @sender = sender
    @receiver = receiver
    @conversation = conversation
    mail(to: @receiver.email, subject: "You've got a message from #{@sender.name} | skill4.space")
  end

  def after_booking_owner(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @owner.email, subject: "#{@space.name} has been booked! | skill4.space")
  end

  def after_booking_booker(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @booker.email, subject: "Thank you for your booking - #{@space.name} | skill4.space")
  end

  def accept_booking(booker, space, conversation)
    @booker = booker
    @space = space
    @owner = space.user
    @conversation = conversation
    mail(to: @booker.email, subject: "Your booking is now accepted - #{@space.name} | skill4.space")
  end

  def decline_booking(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @booker.email, subject: "I'm sorry but your booking is declined - #{@space.name} | skill4.space")
  end
end
