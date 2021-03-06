class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
        user ||= User.new(role: 2) # guest user (not logged in)
        if user.provider?
          can %i[create read search], [Product, Shop]
          can :create, Product, shop: { user_id: user.id }
          #can :create, Shop, shop: { user_id: user.id }
          can :destroy, Product, shop: { user_id: user.id }
          can :update, Product, shop:  { user_id: user.id }
          can :destroy, Shop, shop: { user_id: user.id }
          can :update, Shop, shop: { user_id: user.id }
        elsif user.client?
          can %i[read search search_range_price], [Shop, Product]
        else
          can %i[index show search search], [Shop, Product]
        end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
