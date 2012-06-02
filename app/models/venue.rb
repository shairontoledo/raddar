class Venue
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Taggable
  include Raddar::Watchable
  include Raddar::Votable
  include Raddar::Commentable
  include Raddar::Searchable

  field :name, type: String
  field :description, type: String
  field :address, type: String
  field :city, type: String
  field :coordinates, type: Array
  mount_uploader :cover, CoverUploader
  slug :name

  belongs_to :author, class_name: 'User'

  validates_presence_of :name, :description, :city
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500
  validates_length_of :address, maximum: 100
  validates_length_of :city, maximum: 100


  attr_accessible :name, :description, :address, :city, :cover, :cover_cache

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  def to_s
    "#{self.name} #{self.description} #{self.address} #{self.city} #{self.tags}"
  end
end
