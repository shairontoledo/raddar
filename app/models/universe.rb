class Universe
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Searchable
  include Bootsy::Container

  field :name, type: String
  field :description, type: String
  mount_uploader :image, ImageUploader
  slug :name

  has_many :forums, dependent: :nullify
  has_many :pubs, dependent: :nullify
  has_many :ranks, dependent: :destroy
  #has_and_belongs_to_many :users

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 6_000

  attr_accessible :name, :description, :image, :image_cache


  def highest_rank
    self.ranks.order_by([:level, :desc]).first
  end
end
