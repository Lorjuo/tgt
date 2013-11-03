# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    name "MyString"
    content "MyText"
    link "MyString"
    active false
  end
end
