class Followership
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :followable, polymorphic: true

  validates_presence_of :user, :followable
  validates_uniqueness_of :followable, scope: :user
  validate  do
    add_error(:base,:self_follow) if((self.user == self.followable) && (self.user === self.followable))
  end
end
