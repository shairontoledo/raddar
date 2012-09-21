class Page
  include Raddar::Model
  include Mongoid::Slug
  include Bootsy::Container

  field :name, type: String
  field :title, type: String
  field :content, type: String
  slug :name

  validates_presence_of :name, :content
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 100
  validates_length_of :title, maximum: 200
  validates_length_of :content, maximum: 60_000

  attr_accessible :name, :title, :content

end
