class Comment
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy

  attr_accessible :content

  validates_presence_of :content, :user, :commentable
  validates_length_of :content, maximum: 6000
end
