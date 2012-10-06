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
  field :coordinates, type: Array
  mount_uploader :image, ImageUploader
  slug :name

  belongs_to :user # is not required

  validates_presence_of :name, :description, :coordinates
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500
  validates_length_of :address, maximum: 100
  validates_length_of :city, maximum: 100


  attr_accessible :name, :description, :address, :city, :image, :image_cache

  # Geocoding
  geocoded_by :complete_address              # can also be an IP address
  # after_validation :geocode, :if => :location_changed?
  reverse_geocoded_by :coordinates
  #after_validation :reverse_geocode  # auto-fetch address

  def complete_address
    [self.address, self.city].compact.join(', ')
  end

  def to_s
    [self.name, self.description, self.address, self.city, self.tags].compact.join(' ')
  end
end
