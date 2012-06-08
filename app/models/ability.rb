class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
      # Admin user only

      can :manage, :all

      cannot [:create,:destroy], User

      cannot :destroy, Rank, is_last_level?: false
    elsif user.persisted?
      # Registered user only

      can :show, User

      can :manage, Message, sender_id: user.id
      can :manage, Message, recipient_id: user.id
      cannot :destroy, Message

      can :read, Followership
      can [:create, :destroy], Followership, user_id: user.id

      can :manage, Topic, user_id: user.id
      can :unwatch, Topic
      can :manage, Post, user_id: user.id

      can :read, Vote
      can [:create, :update], Vote, user_id: user.id
      can :manage, Pub, user_id: user.id
      can :manage, Stuff, pub: {user_id: user.id}
      can :manage, Comment, user_id: user.id
      can :manage, Watching, user_id: user.id
      can :create, Tag
      can :manage, Notification, user_id: user.id
      can [:new, :create], Venue
    else
      # Guest user only 
    end
    # Everyone

    can :read, [Forum, Topic, Post, Pub, Stuff, Comment, Tag, Universe, Venue, Page, Rank]
    can :nearby, Venue
    cannot [:edit,:update], [Post, Comment]

  end

end
