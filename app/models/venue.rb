class Venue
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Taggable
  include Raddar::Watchable
  include Raddar::Votable
  include Raddar::Commentable
  include Raddar::Searchable
  include Geocoder::Model::Mongoid

  field :name, type: String
  field :description, type: String
  field :address, type: String
  field :city, type: String
  field :coordinates, type: Array, default: []
  mount_uploader :cover, CoverUploader
  slug :name

  belongs_to :author, class_name: 'User'

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500
  validates_length_of :address, maximum: 100
  validates_length_of :city, maximum: 100


  attr_accessible :name, :description, :address, :city, :cover, :cover_cache

  # Geocoding
  geocoded_by :complete_address               # can also be an IP address
  # after_validation :geocode, :if => :location_changed?
  reverse_geocoded_by :coordinates
  #after_validation :reverse_geocode  # auto-fetch address

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  def complete_address
    [self.address, self.city].compact.join(', ')
  end

  def to_s
    "#{self.name} #{self.description} #{self.address} #{self.city} #{self.tags}"
  end
end
