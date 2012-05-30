class Tagging
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates_presence_of :tag, :taggable
  validates_uniqueness_of :taggable, scope: :tag_id

end
