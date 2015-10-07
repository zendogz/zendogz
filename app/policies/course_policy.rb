class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    # anyone can see course details
    true
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
