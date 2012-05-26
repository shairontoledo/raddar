class Post < Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :topic
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user
  validates_length_of :content, maximum: 6000
end
