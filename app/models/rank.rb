class Rank
  include Raddar::Model

  field :name, type: String
  field :level, type: Integer
  field :description, type: String

  belongs_to :universe

  validates_presence_of :name, :level, :description, :universe_id
  validates_uniqueness_of :name, scope: :universe_id
  validates_uniqueness_of :level, scope: :universe_id
  validates_length_of :name, maximum: 30
  validates_length_of :description, maximum: 200
  validates_numericality_of :level, greater_than_or_equal_to: 1

  attr_accessible :name, :description

  before_destroy :is_last_level?

  def is_last_level?
    self.level == self.universe.ranks.count
  end
end
