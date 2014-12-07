class DogPolicy < ApplicationPolicy

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
    # must be admin or own the dog
    (user && user.admin?) || record.person == user
  end

  def create?
    # must be logged in and either an admin or owner
    user && (user.owner? || user.admin?)
  end

  def update?
    # must be admin or own the dog
    (user && user.admin?) || record.person == user
  end

  def destroy?
    # must be admin or own the dog
    (user && user.admin?) || record.person == user
  end
end