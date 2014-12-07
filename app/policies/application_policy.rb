class ApplicationPolicy
  attr_reader :user,  # User performing the action
              :record # Instance upon which action is performed

  def initialize(user, record)
    #raise Pundit::NotAuthorizedError, "Must be signed in shithead!." unless user
    @user   = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?;
  end

  def new?
    create?
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end