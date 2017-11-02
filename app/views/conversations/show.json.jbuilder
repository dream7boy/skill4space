if @new_messages.present?
  json.new_messages do
    json.array! @new_messages do |message|
      json.receipt_id @receipt_id
      json.id message.id
      json.body message.body
      json.sender_name(message.sender.name)
      json.sender_photo(message.sender.photo)
      json.created(message.created_at.getlocal.strftime("%Y/%m/%d %H:%M%p"))
    end
  end
end
