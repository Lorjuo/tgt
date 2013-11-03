# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_unit do
    week_day 1
    time_begin "2013-10-14 11:07:03"
    time_end "2013-10-14 11:07:03"
    location_summer_id 1
    location_winter_id "MyString"
  end
end
