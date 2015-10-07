class TestimonialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # everyone can see testimonials
      scope.all
    end
  end

  def create?
    # must be logged in
    user
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
