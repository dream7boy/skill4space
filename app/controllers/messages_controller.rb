class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    if params[:body].present?
      if @conversation.receipts[-2].receiver_id == current_user.id
        @receiver = User.find(@conversation.receipts[-1].receiver_id)
      else
        @receiver = User.find(@conversation.receipts[-2].receiver_id)
      end
      send_get_message_email(current_user, @receiver)
      receipt = current_user.reply_to_conversation(@conversation, params[:body])
      redirect_to conversation_path(params[:conversation_id])
    else
      # render "conversations/show"
      flash[:alert] = "Your message is blank."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end

  def send_get_message_email(sender, receiver)
    UserMailer.get_message(sender, receiver).deliver_now
  end
end
