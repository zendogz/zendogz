# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "MyString"
    email "MyString"
    address "MyString"
    city "MyString"
    postal "MyString"
    phone_home "MyString"
    phone_cell "MyString"
    phone_work "MyString"
    integer ""
    date ""
  end
end
