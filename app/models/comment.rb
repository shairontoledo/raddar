class Comment
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps
  include Raddar::Votable

  field :content, type: String

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user, :commentable
  validates_length_of :content, maximum: 6000


  def url options={}
    commentable.path anchor: 'comments'
  end
end
