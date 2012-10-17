class Notification
  include Raddar::Model
  
  field :content, type: String
  field :item_path, type: String
  field :status, type: Symbol, default: :unread

  belongs_to :user, class_name: 'User', inverse_of: :notifications
  belongs_to :notifiable, inverse_of: :triggered_notifications, polymorphic: true

  validates_presence_of :content, :item_path, :user, :status, :notifiable
  validates_length_of :content, maximum: 200
  validates_inclusion_of :status, :in => [:unread,:read], allow_blank: false

  attr_accessible :content, :item_path

  def self.read_all user
    user.notifications.where(status: :unread).update_all(status: :read)
  end

  def self.all_unread user
    user.notifications.where(status: :unread).order_by([:created_at, :desc])
  end
end
