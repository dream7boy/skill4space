require_relative "./bookings_controller.rb"

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipients = User.all - [current_user]
  end

  def create
    @space = Space.find(params[:space_id])
    BookingsController.callback(@space, params[:start_date], params[:end_date], current_user)

    sender = User.find(@space.user.id)
    receipt = sender.send_message(current_user, "Hello! #{current_user.email}, Thank you for your booking!!", "#{@space.name} has been booked!")
    redirect_to conversation_path(receipt.conversation)
  end
end
