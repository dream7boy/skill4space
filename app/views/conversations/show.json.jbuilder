if @new_message.present?
  # json.extract! @new_message, :id, :body
  json.array! @new_message
  # json.post do |json|
  #   json.id @new_message.id
  #   json.body @new_message.body
  #   json.sender_name(@new_message.sender.name)
  #   json.sender_photo(@new_message.sender.photo)
  #   json.sender_photo_path(@new_message.sender.photo.path)
  #   json.created(@new_message.created_at.getlocal.strftime("%Y/%m/%d %H:%M%p"))
  # end
end
