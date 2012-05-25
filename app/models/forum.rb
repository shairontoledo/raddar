class Forum
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  embeds_many :topics, class_name: 'Forums::Topic'

  attr_accessible :title, :description

  validates_presence_of :title, :description
  validates_length_of :title, maximum: 100
  validates_length_of :description, maximum: 500
end
