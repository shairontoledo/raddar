class NotifyMessageJob < Struct.new(:message_id)
  def perform
    message = Message.find message_id
    NoticeMailer.new_message_email(message).deliver if message.recipient_status == :unread
  end
end