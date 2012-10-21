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
  validate { add_error(:base, :blank_coordinates) if self.coordinates.length != 2 }


  attr_accessible :name, :description, :address, :city, :image, :image_cache

  reverse_geocoded_by :coordinates do |obj, results|
    if geo = results.first
      obj.city    = [geo.city, geo.state, geo.country].reject(&:blank?).join(', ') if obj.city.blank?
      obj.address = geo.address if obj.address.blank?
    end
  end

  after_validation :reverse_geocode

  def to_s
    [self.name, self.description, self.address, self.city, self.tags].compact.join(' ')
  end
end
