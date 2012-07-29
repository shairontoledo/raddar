class Message
  include Raddar::Model

  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
  belongs_to :recipient, class_name: 'User', inverse_of: :incoming_messages

  field :content, type: String
  field :sender_status, type: Symbol, default: :read
  field :recipient_status, type: Symbol, default: :unread

  validates_presence_of :content, :sender, :recipient, :sender_status, :recipient_status
  validates_length_of :content, maximum: 2_000
  validates_inclusion_of :sender_status, :recipient_status, :in => [:unread,:read,:deleted], allow_blank: false
  validate do
    add_error(:base,:self_message) if self.sender.id == self.recipient.id
  end

  def self.find_chat user_1, user_2, last=nil

    messages = user_1.sent_messages.where(recipient_id: user_2.id).and(:sender_status.ne => :deleted) + user_1.incoming_messages.where(sender_id: user_2.id).and(:recipient_status.ne => :deleted)

    messages.sort_by!{|message| message.created_at}
    unless last.nil?
      messages = messages.take_while{|message| message.created_at < last.created_at}
    end
    messages
  end

  def self.read_chat owner, user
    owner.incoming_messages.where(sender_id: user.id).and(recipient_status: :unread).update_all(recipient_status: :read)
  end

  def self.read_chats user
    user.incoming_messages.where(recipient_status: :unread).update_all(recipient_status: :read)
  end

  def self.destroy_chat owner, user
    find_chat(owner, user).each do |message|
      if user.id == message.sender_id
        message.recipient_status = :deleted
      else
        message.sender_status = :deleted
      end
      message.save
    end
  end

  def self.find_chats user, status=nil
    chats = []
    condition = (status.nil? ? {:recipient_status.ne => :deleted} : {recipient_status: status})
    (user.incoming_messages.where(condition).distinct(:sender_id) | user.sent_messages.where(condition).distinct(:recipient_id)).each {|user_id| chats << find_chat(user, User.find(user_id))}
    chats.sort_by!{|chat| chat.last.created_at}.reverse!
    chats
  end

  def self.count_unread_chats user
    user.incoming_messages.where(recipient_status: :unread).distinct(:sender_id).count
  end
end
