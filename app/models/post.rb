class Post
  include Raddar::Model
  include Raddar::Votable
  include Raddar::Searchable

  field :content, type: String

  belongs_to :topic
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content, :user, :topic
  validates_length_of :content, maximum: 6000

  def url options={}
    forum_topic_path self.topic.forum, self.topic, post_id: self.id, anchor: "post_#{self.id}"
  end

  def to_s
    self.content
  end
end
