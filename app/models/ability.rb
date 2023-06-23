class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, Course # admin może zarządzać wszystkimi kursami
      can :read, User # admin może czytać dane wszystkich użytkowników
    end

    if user.lecturer?
      can :read, Course # lecturer może czytać kursy
      can [:create, :update], Course, lecturer: user.username # lecturer może tworzyć i aktualizować kursy, gdzie lecturer = username
    end
  end
end
