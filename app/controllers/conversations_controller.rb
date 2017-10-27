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
    receipt = sender.send_message(current_user, 
      "Hi #{current_user.name}, I am #{sender.name}, the owner of #{@space.name}. Thank you for your booking!! Please leave messages if you have any questions. I will respond you soon!!",
       "Message from #{@space.name}")
    redirect_to conversation_path(receipt.conversation)
  end
end
