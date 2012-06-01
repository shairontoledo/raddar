class Watching
  include Raddar::Model

  belongs_to :user
  belongs_to :watchable, polymorphic: true
  
  validates_presence_of :user, :watchable
  validates_uniqueness_of :watchable, scope: :user_id
end
