class Forums::Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  embedded_in :topic, class_name: 'Forums::Topic'
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user
  validates_length_of :content, maximum: 6000
end
