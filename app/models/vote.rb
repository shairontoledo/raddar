class Vote
  include Raddar::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Symbol

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_presence_of :user, :votable, :value
  validates_uniqueness_of :votable, scope: :user_id
  validates_inclusion_of :value, :in => [:like,:dislike], allow_blank: false

end
