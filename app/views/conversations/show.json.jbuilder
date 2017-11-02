if @new_messages.present?
  # json.new_messages do
    json.array! @new_messages do |message|
      json.last_receipt_id @last_receipt_id
      json.id message.id
      json.body message.body
      json.sender_name(message.sender.name)
      json.sender_photo(message.sender.photo)
      if message.sender.photo.present?
        json.sender_photo_path("http://res.cloudinary.com/dlzzsx5ex/image/upload/#{message.sender.photo.path}")
      elsif message.sender.facebook_picture_url.present?
        json.sender_photo_path(message.sender.facebook_picture_url)
      else
        json.sender_photo_path("http://www.queens.edu/_resources/img/placeholders/person-placeholder.jpg")
      end
      json.created(message.created_at.getlocal.strftime("%Y/%m/%d %H:%M%p"))
    end
  # end
end
