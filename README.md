README
====================

TODO:
-------
upload pictures for each course.
x edit more header pictures
x use redcarpet for course description
in place editing for course description and testimonials


Notes:
------

### bootstrap:
- removed bootstrap-sass gem and added bootstrap sass files from [sass-twitter-bootstrap](https://github.com/jlong/sass-twitter-bootstrap) to vendor/assets as per answer [here](http://stackoverflow.com/a/15868449).

Permissions:
------------

  when not logged in
    allows show log in form (FAILED - 1)
    allows log in action (FAILED - 2)
    allows log out (FAILED - 3)
    allows access to home page (FAILED - 4)
    allows access to about page (FAILED - 5)
    allows access to services page (FAILED - 6)
    allows access to contact page (FAILED - 7)
    denies access to unknown page (FAILED - 8)
    allows listing testimonials (FAILED - 9)
    allows viewing testimonials (FAILED - 10)
    denies editing testimonials (FAILED - 11)
    allows listing courses (FAILED - 12)
    allows viewing courses (FAILED - 13)
    denies editing courses (FAILED - 14)
    allows enrolling for a course ('new') (FAILED - 15)
    allows enrolling for a course ('create') (FAILED - 16)
    denies listing lessons (FAILED - 17)
    denies viewing lessons (FAILED - 18)
    denies editing lessons (FAILED - 19)
    allows creating people (FAILED - 20)
    denies updating people (FAILED - 21)
  when logged in as a user
    allows editing own profile (FAILED - 22)
    allows updating own profile (FAILED - 23)
    denies editing another profile (FAILED - 24)
    denies updating another profile (FAILED - 25)
  when logged in as a student
    allows listing lessons (FAILED - 26)
    allows viewing lessons (FAILED - 27)
    denies editing lessons (FAILED - 28)
  when logged in as an owner
    allows dogs new (FAILED - 29)
    allows dogs create (FAILED - 30)
    denies dogs edit (FAILED - 31)
    allows edit own dogs (FAILED - 32)
    denies edit others dogs (FAILED - 33)
  when logged in as an admin
    allows all controllers and actions (FAILED - 34)

ability.rb
----------
def initialize(user)
    if user
      # logged in
      allow_all if user.role?(:admin)
      allow :people, [:show, :edit, :update] do |person|
        person.id == user.id
      end
      allow :lessons, [:index, :show]
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
    allow :enrollments, [:new, :create]
    allow :debug, [:index]
  end
