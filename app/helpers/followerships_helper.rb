module FollowershipsHelper
  def followers_path followable
    polymorphic_path([followable, :followers])
  end
end
