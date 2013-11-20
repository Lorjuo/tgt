class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :manage, :all
    elsif user.has_role?('editor')
      # Department dependent

      can [:create, :read, :update, :sort_navigation_elements], Department do |department|
        user.departments.include? department
      end

      can [:create, :read, :update, :destroy], TrainingGroup do |training_group|
        user.departments.include? training_group.department
      end

      can [:create, :read, :update, :destroy], TrainingUnit do |training_unit|
        user.departments.include? training_unit.training_group.department
      end

      # General

      can [:create, :read, :update, :destroy], Trainer

      can [:create, :read, :update, :destroy], Location

      # WYSIWYG

      can :manage, :elfinder

      # ATTACHABLES
      
      can [:create, :read, :update, :destroy], Image
      can [:create, :read, :update, :destroy], Document

      # TODO
      can :training_groups, :department

      can :rebuild, NavigationElement

      can [:create, :read, :update, :destroy], Message

      can [:create, :read, :update, :destroy], Event

      #TODO: Set abilities for images, documents and uploaders
      #Maybe. http://stackoverflow.com/questions/8170475/cancan-abilities-for-inherited-resources-with-nesting-in-controller
    end

    # Everyone
    can :read, :all
    can :manage, :static_page

    can [:schedule, :interactive_map], Location
    can [:training_groups, :trainers, :messages, :schedule], Department

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
