# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carnival_order, :class => 'Carnival::Order' do
    person_id 1
    notice "MyString"
  end
end
