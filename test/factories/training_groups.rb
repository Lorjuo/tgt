# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_group do
    name "MyString"
    description "MyText"
    department_id 1
    age_begin 1
    age_end 1
  end
end
