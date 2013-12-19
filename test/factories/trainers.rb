# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trainer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday "2013-10-14"
    residence "MyString"
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    profession "MyText"
    education "MyText"
    disciplines "MyText"
    activities "MyText"
  end
end
