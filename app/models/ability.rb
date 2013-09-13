class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :new, :edit, :create, :update, :destroy, :to => :operate
    alias_action :relay, :index, :show, :to => :use
    alias_action :top, :top_experiences, :top_notes, :top_reviews, :to => :look
    if user.role? :admin
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      can :manage, :all
    elsif user.role? :user
      can :manage, :all
      cannot :operate, [Knowledge, Resource] do
        #forbid user create nodes if created count greated than 30
        user.created_nodes_count_today >= 30
      end
      cannot :show, [Knowledge, Resource] do |node|
        node.publish != true and node.user != user
      end
    else
      can :read, :all
      can :look, :all
      cannot :show, [Knowledge, Resource] do |node|
        node.publish != true
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
