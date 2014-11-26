class LessonPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      scope.all
    end
  end

  def show?
    # must be logged in to see lesson details
    user
  end

  def create?
    # must be admin
    user && user.admin?
  end

  def update?
    # must be admin
    user && user.admin?
  end

  def destroy?
    # must be admin
    user && user.admin?
  end
end
