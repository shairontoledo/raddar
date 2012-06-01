class Topic
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Raddar::Watchable

  field :name, type: String
  field :views, type: Integer, default: 0
  slug :name

  belongs_to :forum
  has_many :posts
  belongs_to :user

  attr_accessible :name

  validates_presence_of :name, :user
  validates_length_of :name, maximum: 100

  def first_posts
    self.posts.order_by([:created_at, :asc])
  end

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  def url options={}
    forum_topic_path self.forum, self, options
  end
end
