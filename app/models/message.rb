class Message
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
  belongs_to :recipient, class_name: 'User', inverse_of: :incoming_messages

  field :content, type: String
  field :sender_status, type: Symbol, default: :read
  field :recipient_status, type: Symbol, default: :unread

  validates_presence_of :content, :sender, :recipient, :sender_status, :recipient_status
  validates_length_of :content, maximum: 2000
  validates_inclusion_of :sender_status, :recipient_status, :in => [:unread,:read,:deleted], allow_blank: false
  validate  do
    add_error(:base,:self_message) if self.sender.id == self.recipient.id
  end

end
