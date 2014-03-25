FactoryGirl.define do

  factory :person do
    sequence(:name) { |n| "test#{n}" }
    password 'pass'
    password_confirmation 'pass'
    email { "#{name}+#{Rails.application.class.parent_name}@raceweb.ca" }
  end

  factory :testimonial do
    from 'from name'
    body 'body text'
  end

  factory :dog do
    sequence(:name) { |n| "rex#{n}" }
  end

  factory :course do
    sequence(:name) { |n| "learn to walk #{n}" }
    description 'learn to do stuff with your dog'
  end

  factory :lesson do
    sequence(:name) { |n| "lesson #{n}" }
    handout "handout"
    lesson_at Time.now + 3.days
    status nil
  end

  factory :code do
    set Code.new(set_id: 1, code: 'root', description: 'root')
    code "new_code"
    description "new code description"
  end

end
