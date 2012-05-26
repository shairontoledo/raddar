class Topic < Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :views, type: Integer, default: 0

  belongs_to :forum
  has_many :posts
  belongs_to :user

  attr_accessible :title

  validates_presence_of :title, :user
  validates_length_of :title, maximum: 100

  def first_posts
    self.posts.order_by([:created_at, :asc])
  end
end
