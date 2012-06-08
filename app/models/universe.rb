class Universe
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Searchable

  field :name, type: String
  field :description, type: String
  mount_uploader :cover, CoverUploader
  slug :name

  has_many :forums, dependent: :nullify
  has_many :pubs, dependent: :nullify
  has_many :ranks, dependent: :destroy

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 6000

  attr_accessible :name, :description, :cover, :cover_cache


  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end
end
