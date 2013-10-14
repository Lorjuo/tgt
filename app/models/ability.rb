class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :manage, :all
    else
      can :read, :all
      can :manage, :static_page
      can :training_groups, :department

      can :rebuild, Page

      can [:create, :read, :update, :sort_pages, :training_groups], Department do |department|
        user.departments.include? department
      end

      can [:create, :read, :update, :destroy], TrainingGroup do |training_group|
        user.departments.include? training_group.department
      end
    end
    #
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
