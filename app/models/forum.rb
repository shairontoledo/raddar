class Forum
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  field :name, type: String
  field :description, type: String
  slug :name

  has_many :topics
  belongs_to :universe

  attr_accessible :name, :description, :universe_id

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500

  before_destroy :has_no_topics?

  def last_topics
    self.topics.order_by [:updated_at, :desc]
  end

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end

  private
  def has_no_topics?
    if self.topics.empty?
      return true
    else
      add_error(:base,:has_topics)
      return false
    end
  end
end
