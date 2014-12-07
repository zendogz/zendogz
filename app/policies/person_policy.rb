class PersonPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user
        user.admin? ? scope.all : scope.where(id: user.id)
      else
        Person.none
      end
    end
  end

  def show?
    # admins can see everyone, users can only see their own details
    user.admin? || record.id == user.id if user
  end

  def create?
    # guests can create, that's registering
    true
  end

  def update?
    # admins can update everyone, users can only update their own details
    user.admin? || record.id == user.id if user
  end

  def destroy?
    # must be admin
    user && user.admin?
  end

end
