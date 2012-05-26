class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
      # Admin user only

      can :manage, :all

      cannot [:create,:destroy], User
    elsif user.persisted?
      # Registered user only

      can :show, User

      can :manage, Message, sender_id: user.id
      can :manage, Message, recipient_id: user.id
      cannot :destroy, Message

      can :read, Followership
      can [:create, :destroy], Followership, user_id: user.id

      can :manage, Topic, user_id: user.id
      can :manage, Post, user_id: user.id

      can :read, Vote
      can [:create, :update], Vote, user_id: user.id
    else
      # Guest user only 
    end
    # Everyone

    can :read, [Forum, Topic, Post]
    cannot [:edit,:update], Post

  end

end
