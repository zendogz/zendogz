#
# manage authorization for the current user
#

class Permission

  #
  # constructor called from application_controller.authorize() which is a before_filter
  #
  def initialize(user)
    if user
      # logged in
      allow_all if user.role?(:admin)
      allow :people, [:show, :edit, :update] do |person|
        person.id == user.id
      end
      allow :lessons, [:index, :show]
      allow :enrollments, [:new, :create]
      if user.role?(:owner)
        allow :dogs, [:index, :new, :create]
        allow :dogs, [:show, :edit, :update, :destroy] do |dog|
          dog.person_id == user.id
        end
        allow :notes, [:index, :show, :new, :create, :edit, :update, :destroy]
      end
    end

    # everybody
    allow :pages, [:home, :about, :services, :contact]
    allow :sessions, [:new, :create, :destroy]
    allow :people, [:new, :create]
    allow :testimonials, [:index, :show]
    allow :courses, [:index, :show]
    allow :debug, [:index]
  end

  def allow_all
    @allow_all = true
  end

  #
  # build the hash of allowed actions. the hash will look like this:
  # { ['dogs','create'] => true, ['dogs','update'] => <Proc...>, ['pages', 'contact'] => true, ... }
  #
  def allow(controller, actions, &block)
    @allowed_actions ||= {}
    if controller
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  #
  # called from the views to tell if the current user can perform an action
  #
  def can?(controller, action, resource = nil)
    can = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    can && (can == true || resource && can.call(resource))
  end
end
