# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
    sequence(:name) { |n| "foo#{n}department"}
  end
end
