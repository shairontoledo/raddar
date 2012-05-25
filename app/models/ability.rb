class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
      can :manage, :all
      cannot :destroy, User
      cannot :create, User
    elsif user.persisted?
      can :show, User
      can :manage, Message, sender_id: user.id
      can :manage, Message, recipient_id: user.id
      cannot :destroy, Message
      can :read, Followership
      can [:create, :destroy], Followership, user_id: user.id
    else
      # permissions for guest user
    end
  end

end
