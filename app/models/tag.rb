class Tag
  include Raddar::Model

  field :name, type: String

  has_many :taggings, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  def url options={}
    search_path(q: self.name)
  end
end