class Post
  include Raddar::Model
  include Raddar::Votable

  field :content, type: String

  belongs_to :topic, touch: true
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user, :topic
  validates_length_of :content, maximum: 6000
end
