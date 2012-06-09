class Pub
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  field :name, :type => String
  field :subtitle, :type => String
  field :description, :type => String
  mount_uploader :image, ImageUploader
  slug :name

  belongs_to :user
  has_many :stuffs, dependent: :destroy
  belongs_to :universe

  validates_presence_of :name, :description, :user
  validates_length_of :name, maximum: 100
  validates_length_of :subtitle, maximum: 120
  validates_length_of :description, maximum: 6000

  attr_accessible :name, :subtitle, :description, :image, :image_cache, :universe_id

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  def to_s
    "#{self.name} #{self.subtitle} #{self.description}"
  end
end
