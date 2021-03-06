class Comment
  include Raddar::Model
  include Raddar::Votable

  field :content, type: String

  belongs_to :commentable, touch: true, polymorphic: true
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user, :commentable
  validates_length_of :content, maximum: 6000
end
