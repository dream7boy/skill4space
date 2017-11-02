require_relative "./bookings_controller.rb"

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @booking = Booking.find_by(conversation: params[:id])
    # puts params[:message][:id]
    respond_to do |format|
      format.html
      # format.js { @new_message = @conversation.receipts_for(current_user).find(params[:message][:id]).message }
      # format.json { @new_message = @conversation.receipts_for(current_user).find(params[:message][:id]).message }
      format.json do
        @receipt_id = params[:receipt][:id]
        @last_receipt_id = @receipt_id.to_i + 2
        last_message_in_ui = @conversation
                                .receipts_for(current_user)
                                .find(@receipt_id).message
        @new_messages = last_message_in_ui
                            .conversation
                            .messages
                            .where('id > ?', last_message_in_ui.id)
                            # .where('created_at > ?', last_message_in_ui.created_at)
        puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
        p params[:receipt][:id]
        p last_message_in_ui.id
        p @new_messages
        puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      end

# c.receipts_for(u).order(created_at: :desc).first.message
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
    redirect_to conversation_path(receipt.conversation)
  end
end

#   def show
#     @conversation = current_user.mailbox.conversations.find(params[:id])
#     @booking = Booking.find_by(conversation: params[:id])
#     # puts params[:message][:id]
#     respond_to do |format|
#       format.html
#       # format.js { @new_message = @conversation.receipts_for(current_user).find(params[:message][:id]).message }
#       # format.json { @new_message = @conversation.receipts_for(current_user).find(params[:message][:id]).message }
#       format.json do
#         @receipt_id = params[:receipt][:id]
#         last_message_in_ui = @conversation
#                                 .receipts_for(current_user)
#                                 .find(@receipt_id).message
#         @new_messages = last_message_in_ui
#                             .conversation
#                             .messages
#                             .where('id > ?', last_message_in_ui.id)
#                             # .where('created_at > ?', last_message_in_ui.created_at)
#         puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
#         p params[:receipt][:id]
#         p last_message_in_ui.created_at
#         p @new_messages
#         puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
#       end

# # c.receipts_for(u).order(created_at: :desc).first.message
#     end
#   end
