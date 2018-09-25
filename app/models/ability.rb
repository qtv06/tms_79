class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    return if user.blank?
    case controller_namespace
    when 'BasicTrainee'
      can :show_profile, User
      can :edit_my_profile, User, id: user.id
      can [:start_task, :finish_task], Subject
    else
      can :manage, :all if user.suppervisor?
    end
  end
end
