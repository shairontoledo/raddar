module FollowershipsHelper
  def followers_path followable
    eval "#{followable.class.name.underscore}_followers_path(followable)"
  end
end
