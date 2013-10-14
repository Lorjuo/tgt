json.array!(@trainers) do |trainer|
  json.extract! trainer, :first_name, :last_name, :birthday, :residence, :phone, :email, :profession, :education, :disciplines, :activities
  json.url trainer_url(trainer, format: :json)
end
