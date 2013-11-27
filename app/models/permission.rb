# example data structure for @allowed actions:
# { ['dogs','create'] => true, ['dogs','update'] => true, ['pages', 'all'] => true }

class Permission

  def initialize(user)
    if user
      allow_all if user.role?(:admin)
      allow :people, [:show, :edit, :update]
      if user.role?(:owner)
        allow :dogs
        allow :notes
      end
    end
    allow :pages
    allow :sessions
    allow :people, [:new, :create]
    allow :testimonials, [:index, :show]
    allow :courses, [:index, :show]
  end

  def allow_all
    @allow_all = true
  end

  def allow(controller, actions = :all, resource = nil)
    @allowed_actions ||= {}
    if controller
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = true
      end
    end
  end

  def can?(controller, action = nil, resource = nil)
    action = :all unless action
    can = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    can && (can == true || resource && can.call(resource))
  end
end
