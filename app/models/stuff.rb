class Stuff
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, :type => String
  field :content, :type => String
  mount_uploader :cover, CoverUploader

  belongs_to :pub

  validates_presence_of :name, :content, :pub
  validates_length_of :name, maximum: 100
  validates_length_of :content, maximum: 30000

  attr_accessible :name, :content, :cover, :cover_cache
end
