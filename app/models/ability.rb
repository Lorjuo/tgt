class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :manage, :all
    elsif user.has_role?('editor')

      # General

      can [:create, :read, :update, :destroy], Location

      # WYSIWYG

      can :manage, :elfinder

      # ATTACHABLES
      
      can [:create, :read, :update, :destroy], Image
      can [:create, :read, :update, :destroy], Document

      # TODO
      can :training_groups, :department

      can :rebuild, Link

      can [:create, :read, :update, :destroy], Event

      can [:create, :read, :update, :destroy], Announcement

      #TODO: Set abilities for images, documents and uploaders
      #Maybe. http://stackoverflow.com/questions/8170475/cancan-abilities-for-inherited-resources-with-nesting-in-controller
    end

    # Everyone
    can :read, :all
    can :manage, :static_page

    can [:schedule, :interactive_map], Location
    can [:training_groups, :trainers, :messages, :schedule, :galleries, :documents], Department
    can [:search], TrainingGroup


    # Department dependent
    can [:create, :read, :update], Department do |department|
      user.departments.include? department
    end

    can [:create, :read, :update, :destroy, :sort], [Link, ExternLink, MediaLink, Placeholder, Page] do |link|
      user.departments.include? link.department
    end

    can [:create, :read, :update, :destroy], TrainingGroup do |training_group|
      user.departments.include? training_group.department
    end

    can [:create, :read, :update, :destroy], TrainingUnit do |training_unit|
      user.departments.include? training_unit.try(:training_group).try(:department)
      # try syntax needed because there are sometimes no dependencies in tests
    end

    can [:create, :read, :update, :destroy], Message do |message|
      user.departments.include? message.department
    end

    can [:create, :read, :update, :destroy], Gallery do |gallery|
      user.departments.include? gallery.department
    end

    can [:create, :read, :update, :destroy], Image

    can [:create, :read, :update, :destroy], Trainer do |trainer|
      # Multiple joins:
      # http://stackoverflow.com/questions/11417287/advanced-query-in-rails-with-multiple-joins
      # Unique:
      # http://stackoverflow.com/questions/9658881/rails-select-unique-values-from-a-column
      department_ids = Department.uniq.joins(training_groups: :trainers).where('trainers.id' => trainer.id).map(&:id)
      # Double sided include?
      # http://stackoverflow.com/questions/8026300/check-for-multiple-items-in-array-using-include-ruby-beginner
      user.departments.map(&:id).any? { |x| department_ids.include?(x) }
    end


    # Trainer dependent


    can [:update], Trainer do |trainer|
      user.trainer == trainer
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
