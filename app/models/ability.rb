class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.persisted?
      # Registered user only
      if user.role? :admin
        # Admin user only
        can :manage, :all
        cannot [:create,:destroy], User
        cannot :destroy, Rank, is_last_level?: false
        cannot [:create], Stuff
        can [:create], Stuff, pub: {user_id: user.id}
      else

        can :manage, Account, user_id: user.id
        can [:create, :destroy], Comment, user_id: user.id
        can [:create, :destroy], Followership, user_id: user.id
        can :manage, Message, sender_id: user.id
        can [:read, :destroy_all], Message, recipient_id: user.id
        can :manage, Notification, user_id: user.id
        can :manage, :notification
        can :manage, :password
        can :manage, Post, user_id: user.id
        can :manage, :privacy
        can :manage, Pub, user_id: user.id
        cannot [:set_main, :remove_main], Pub
        can :manage, Stuff, pub: {user_id: user.id}
        can :create, Tag
        can :manage, Topic, user_id: user.id
        can :read, User, active?: true
        can [:new, :create], Venue
        can :create, Vote
        can :manage, Watching, user_id: user.id
        
        cannot [:edit,:update], [Comment, Message, Post]

      end
    end
    # Everyone
    can :read, [Followership, Forum, Pub, Stuff, Topic]
    can :show, [Comment, Forum, Page, Post, Rank, Tag, Universe, Vote]
    can [:read, :nearby], Venue
    can [:index, :search, :exception], :home
    can :read, :followee
    can [:new, :create], Contact
  end
end
