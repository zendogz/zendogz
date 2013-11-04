class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.role?('admin')
        can :manage, :all
    elsif user.role?('owner')
        # can manage owned dogs
        can :manage, Dog, person_id: user.id
        # can manage notes for owned dogs
        can :manage, Note, dog: { person_id: user.id }
    end
    can :read, [Testimonial, Course]
  end
end
