class EnrollmentPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user
        user.admin? ? scope.all : scope.where(person: user)
      else
        scope.none
      end
    end
  end

  def show?
    # must be admin or the student
    (user && user.admin?) || record.person == user
  end

  def create?
    # anyone can enroll
    true
  end

  def update?
    # must be admin or the student
    (user && user.admin?) || record.person == user
  end

  def destroy?
    # must be admin
    user && user.admin?
  end

end
