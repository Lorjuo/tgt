# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    #sequence(:first_name) { |n| "foo#{n}username"}
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password {first_name}
    email {"#{first_name}@tgtraisa.de"}

    factory :admin do
      #admin true
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
