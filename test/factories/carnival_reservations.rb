# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carnival_reservation, :class => 'Carnival::Reservation' do
    order_id 1
    session_id 1
    category_id 1
    amount 1
  end
end
