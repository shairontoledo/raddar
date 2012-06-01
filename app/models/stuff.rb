class Stuff
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Raddar::Taggable
  include Raddar::Watchable
  include Raddar::Votable
  include Raddar::Commentable


  field :name, :type => String
  field :content, :type => String
  mount_uploader :cover, CoverUploader
  slug :name

  belongs_to :pub

  validates_presence_of :name, :content, :pub
  validates_length_of :name, maximum: 100
  validates_length_of :content, maximum: 30000

  attr_accessible :name, :content, :cover, :cover_cache

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
end
