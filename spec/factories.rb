# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :person do
    sequence(:name) { |n| "test#{n}" }
    password "pass"
    password_confirmation "pass"
    email { "#{name}+#{Rails.application.class.parent_name}@raceweb.ca" }
  end

  factory :testimonial do
    from "MyString"
    body "MyText"
  end
end
