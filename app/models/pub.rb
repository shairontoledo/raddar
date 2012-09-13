class Pub
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  field :name, type: String
  field :description, type: String
  field :main, as: :main?, type: Boolean, default: false
  mount_uploader :image, ImageUploader
  slug :name

  belongs_to :user
  has_many :stuffs, dependent: :destroy
  belongs_to :universe

  validates_presence_of :name, :description, :user
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 66_000

  attr_accessible :name, :description, :image, :image_cache, :universe_id

  def last_stuffs
    self.stuffs.order_by [:created_at, :desc]
  end

  def to_s
    "#{self.name} #{self.description}"
  end
end
