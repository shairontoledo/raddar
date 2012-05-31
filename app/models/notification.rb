class Notification
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content, type: String
  field :image_path, type: String
  field :item_path, type: String
  field :status, type: Symbol, default: :unread

  belongs_to :user

  validates_presence_of :content, :item_path, :user, :status
  validates_length_of :content, maximum: 200
  validates_inclusion_of :status, :in => [:unread,:read], allow_blank: false

  attr_accessible :content, :image_path, :item_path
end
