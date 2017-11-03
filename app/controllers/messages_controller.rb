class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    if params[:body].present?
      @receiver = @conversation
                    .receipts
                    .last(2)
                    .map(&:receiver)
                    .find { |receiver| receiver != current_user }

      # second_to_last_receipt_receiver_id, last_receipt_receiver_id = @conversation
      #                                                                     .receipts
      #                                                                     .last(2)
      #                                                                     .map(&:receiver_id)
      # @receiver = if second_to_last_receipt_receiver_id == current_user.id
      #   User.find(last_receipt_receiver_id)
      # else
      #   User.find(second_to_last_receipt_receiver_id)
      # end

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
