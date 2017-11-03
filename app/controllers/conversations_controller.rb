require_relative "./bookings_controller.rb"

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @booking = Booking.find_by(conversation: params[:id])
    respond_to do |format|
      format.html
      format.json do
        @receipt_id = (params[:receipt][:id]).to_i
        @last_receipt_id = @conversation.receipts_for(current_user).last.id

        last_message_in_ui = @conversation
                                .receipts_for(current_user)
                                .find(@receipt_id).message

        @new_messages = last_message_in_ui
                            .conversation
                            .messages
                            .where('id > ?', last_message_in_ui.id)
                            # .where('created_at > ?', last_message_in_ui.created_at)
      end
    end
  end

  def new
    @recipients = User.all - [current_user]
  end

  def create
    @space = Space.find(params[:space_id])
    # BookingsController.callback(@space, params[:start_date], params[:end_date], current_user)

    sender = User.find(@space.user.id)
    receipt = sender.send_message(current_user,
      "Hi #{current_user.name}, I am #{sender.name}, the owner of #{@space.name}. Thank you for your booking!! Please leave messages if you have any questions. I will respond you soon!!",
       "#{@space.name}")

    BookingsController.callback(@space, current_user, receipt.conversation.id)
    render :json => { conversation: receipt.conversation }
  end
end
