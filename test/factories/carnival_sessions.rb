# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carnival_session, :class => 'Carnival::Session' do
    name "MyString"
    term "2013-12-05"
  end
end
