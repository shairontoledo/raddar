class Tag
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :taggings, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
end
