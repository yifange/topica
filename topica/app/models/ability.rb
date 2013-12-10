class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    can :create,  :all
    can :read,    :all
    if User.exists?(user)
      can [:update, :destroy], User do |u|
        u.id == user.id
      end
    end
  end
end
