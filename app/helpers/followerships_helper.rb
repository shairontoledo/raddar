module FollowershipsHelper
  def followers_path followable
    eval "#{followable.class.name.downcase}_followers_path(followable)"
  end
end
