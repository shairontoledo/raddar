class Topic < Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :views, type: Integer, default: 0

  belongs_to :forum
  has_many :posts
  belongs_to :user
  has_and_belongs_to_many :watchers, class_name: 'User', inverse_of: :watched_topics, dependent: :nullify

  attr_accessible :name

  validates_presence_of :name, :user
  validates_length_of :name, maximum: 100

  def first_posts
    self.posts.order_by([:created_at, :asc])
  end
end
