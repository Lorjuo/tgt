# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    name "MyString"
    department_id 1
    content "MyText"
  end
end
