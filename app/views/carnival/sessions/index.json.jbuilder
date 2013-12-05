json.array!(@carnival_sessions) do |carnival_session|
  json.extract! carnival_session, :name, :term
  json.url carnival_session_url(carnival_session, format: :json)
end
