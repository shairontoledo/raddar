class Role
  include Raddar::Model

  field :name, :type => Symbol

  has_and_belongs_to_many :users

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_inclusion_of :name, :in => [:admin], allow_blank: false
end
