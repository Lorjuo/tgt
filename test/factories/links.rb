# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    name "MyString"
    lft 1
    rgt 1
    depth 1
    department_id 1
  end
end
