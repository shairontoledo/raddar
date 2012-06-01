class Followership
  include Raddar::Model

  belongs_to :user
  belongs_to :followable, polymorphic: true

  validates_presence_of :user, :followable
  validates_uniqueness_of :followable, scope: :user_id
  validate  do
    add_error(:base,:self_follow) if((self.user == self.followable) && (self.followable.class == User))
  end
end
