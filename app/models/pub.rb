class Pub
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, :type => String
  field :subtitle, :type => String
  field :description, :type => String
  mount_uploader :cover, CoverUploader

  belongs_to :user
  has_many :stuffs, dependent: :destroy
  has_many :followers, class_name: 'Followership', as: :followable, dependent: :destroy

  validates_presence_of :name, :description, :user
  validates_length_of :name, maximum: 100
  validates_length_of :subtitle, maximum: 120
  validates_length_of :description, maximum: 6000

  attr_accessible :name, :subtitle, :description, :cover, :cover_cache

end
