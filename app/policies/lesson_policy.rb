class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        user.admin? ? scope.all : scope.where(course_id: user.courses.ids)
      else
        Lesson.none
      end
    end
  end

  def show?
    # must be enrolled in course to see lesson details
    user.admin? || user.enrolled?(record.course) if user
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
