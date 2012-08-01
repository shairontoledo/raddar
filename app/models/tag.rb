class Tag
  include Raddar::Model
  include Mongoid::Slug

  field :name, type: String
  slug :name

  has_many :taggings, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  validates_length_of :name, maximum: 100

end
