# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trainer do
    first_name "MyString"
    last_name "MyString"
    birthday "2013-10-14"
    residence "MyString"
    phone "MyString"
    email "MyString"
    profession "MyText"
    education "MyText"
    disciplines "MyText"
    activities "MyText"
  end
end
