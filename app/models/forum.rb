class Forum
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  field :name, type: String
  field :description, type: String
  slug :name

  has_many :topics, dependent: :destroy
  belongs_to :universe #is not required

  attr_accessible :name, :description, :universe_id

  validates_presence_of :name, :description
  validates_length_of :name, maximum: 100
  validates_length_of :description, maximum: 500

  before_destroy :ready_for_destruction?

  def last_topics
    self.topics.order_by [:updated_at, :desc]
  end

  def to_s
    [self.name, (self.universe.nil? ? nil : self.universe.name)].compact.join(' ')
  end

  private
  def ready_for_destruction?
    if self.topics.empty?
      return true
    else
      add_error(:base,:has_topics)
      return false
    end
  end
end
