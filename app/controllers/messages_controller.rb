class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    if params[:body].present?
      if @conversation.receipts[-2].receiver_id == current_user.id
        @receiver = User.find(@conversation.receipts[-1].receiver_id)
      else
        @receiver = User.find(@conversation.receipts[-2].receiver_id)
      end
      send_get_message_email(current_user, @receiver, @conversation)
      @receipt = current_user.reply_to_conversation(@conversation, params[:body])
    end
    respond_to do |format|
      format.html { render "conversations/show" }
      format.js
    end
  end

  private

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end

  def send_get_message_email(sender, receiver, conversation)
    UserMailer.get_message(sender, receiver, conversation).deliver_now
  end
end
