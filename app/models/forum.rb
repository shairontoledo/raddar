class Forum
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Raddar::Followable

  field :name, type: String
  field :description, type: String
  slug :name

  has_many :topics
  belongs_to :universe

  attr_accessible :name, :description, :universe_id

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500

  before_destroy :has_no_topics?

  def has_no_topics?
    if self.topics.empty?
      return true
    else
      add_error(:base,:has_topics)
      return false
    end
  end

  def last_topics
    topics = self.topics.to_a
    topics.sort_by! do |topic| 
      unless topic.first_posts.empty? 
        topic.first_posts.last.created_at
      else
        topic.created_at
      end
    end 

    topics.reverse!
    topics
  end

  def self.last_forums
    forums = Forum.all.to_a
    forums.sort_by! do |forum| 
      unless forum.last_topics.empty? 
        forum.last_topics.first.first_posts.last.created_at
      else
        forum.created_at
      end
    end 

    forums.reverse!
    forums
  end

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end
end
