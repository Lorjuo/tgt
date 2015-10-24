json.array!(@carnival_reservations) do |carnival_reservation|
  json.extract! carnival_reservation, :order_id, :session_id, :category_id, :amount
  json.url carnival_reservation_url(carnival_reservation, format: :json)
end
