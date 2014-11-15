class DogPolicy < ApplicationPolicy

	class Scope
  	attr_reader :user, :scope

  	def initialize(user, scope)
    	@user = user
    	@scope = scope
  	end

  	def resolve
    	if user && user.admin?
        scope.all
    	else
        scope.where(:owner == user)
    	end
  	end
	end

  def index?  ; true; end
  def show?   ; true; end
  def create? ; true; end
  def update? ; record.person == user; end
  def destroy?; record.person == user; end
end