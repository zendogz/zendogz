FactoryGirl.define do
  factory :person do
    sequence(:name) { |n| "foo#{n}" }
    email { "#{name}@raceweb.ca" }
    authority 3

    factory :admin do
      authority 1
    end
  end

  factory :dog do
    name "Foo"
    user
  end
end