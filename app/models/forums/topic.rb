class Forums::Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :views, type: Integer, default: 0

  embedded_in :forum
  embeds_many :posts, class_name: 'Forums::Post'
  belongs_to :user

  attr_accessible :title

  validates_presence_of :title, :user
  validates_length_of :title, maximum: 100
end
