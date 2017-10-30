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
    mail(to: @receiver, subject: "You've got a message from #{@sender}")
  end
end
