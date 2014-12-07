class NotePolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user
        user.admin? ? scope.all : scope.where(dog_id: user.dogs.ids)
      else
        Note.none
      end
    end
  end

  def show?
    # note must be for a dog that the user owns
    user.admin? || user == record.dog.person if user
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
