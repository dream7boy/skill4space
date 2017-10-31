class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to Skill4space')

    # @greeting = "Hi"

    # mail to: "to@example.org"
  end

  def get_message(sender, receiver)
    @sender = sender
    @receiver = receiver
    mail(to: @receiver.email, subject: "You've got a message from #{@sender.name}")
  end

  def after_booking_owner(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @owner.email, subject: "#{@space.name} has been booked!")
  end

  def after_booking_booker(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @booker.email, subject: "Booking Made - #{@space.name}")
  end

  def accept_booking(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @booker.email, subject: "Booking Accepted - #{@space.name}")
  end

  def decline_booking(booker, space)
    @booker = booker
    @space = space
    @owner = space.user
    mail(to: @booker.email, subject: "Booking Declined - #{@space.name}")
  end
end
