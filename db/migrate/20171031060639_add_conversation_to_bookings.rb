class AddConversationToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :conversation, :integer
  end
end
