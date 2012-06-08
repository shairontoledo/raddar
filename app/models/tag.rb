class Tag
  include Raddar::Model
  include Mongoid::Slug

  field :name, type: String
  slug :name

  has_many :taggings, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  def self.find *args
    if args.length == 1 and not args[0].is_a? Symbol
      find_by_slug(*args) || super
    else
      super
    end
  end
end
