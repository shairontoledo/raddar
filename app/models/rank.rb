class Rank
  include Raddar::Model

  field :name, type: String
  field :level, type: Integer
  field :description, type: String

  belongs_to :universe
  has_and_belongs_to_many :users, dependent: :nullify

  validates_presence_of :name, :level, :description, :universe
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

  def highest_users
    highest = []
    self.users.each do |user|
      highest << user if Rank.highest(user, self.universe) == self
    end
    highest.reverse
  end

  def self.highest user, universe
    rank = user.ranks.where(universe_id: universe.id).order_by([:level, :desc]).first
    if rank.nil?
      rank = universe.ranks.order_by([:level, :asc]).first
      user.ranks << rank
    end
    rank
  end
end
