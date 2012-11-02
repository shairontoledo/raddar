class Stuff
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Taggable
  include Raddar::Watchable
  include Raddar::Votable
  include Raddar::Commentable
  include Raddar::Searchable

  field :name, type: String
  field :content, type: String
  field :views, type: Integer, default: 0
  mount_uploader :image, ImageUploader
  slug :name

  belongs_to :pub, touch: true

  validates_presence_of :name, :content, :pub
  validates_length_of :name, maximum: 100
  validates_length_of :content, maximum: 66_000

  attr_accessible :name, :content, :image, :image_cache, :pub_id

  def to_s
    [self.name, self.pub.to_s, self.tags].compact.join(' ')
  end

  def description
    [self.pub.name, self.content].join(' - ')
  end
end
