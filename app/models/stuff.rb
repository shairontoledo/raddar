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
  mount_uploader :image, ImageUploader
  slug :name

  belongs_to :pub, touch: true

  validates_presence_of :name, :content, :pub
  validates_length_of :name, maximum: 100
  validates_length_of :content, maximum: 60_000

  attr_accessible :name, :content, :image, :image_cache

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  def url options={}
    pub_stuff_path self.pub, self, options
  end

  def to_s
    "#{self.name} #{self.content} #{self.tags}"
  end
end
