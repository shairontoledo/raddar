class Forum < Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  has_many :topics

  attr_accessible :title, :description

  validates_presence_of :title, :description
  validates_length_of :title, maximum: 100
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
end
