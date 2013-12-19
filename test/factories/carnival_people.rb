# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carnival_person, :class => 'Carnival::Person' do
    first_name "MyString"
    last_name "MyString"
    street "MyString"
    zip "MyString"
    city "MyString"
    email "MyString"
    phone "MyString"
  end
end
