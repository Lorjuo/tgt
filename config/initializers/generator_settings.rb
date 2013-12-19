Rails.application.config.generators do |g|
  g.test_framework :mini_test, :spec => false
end

# stop Rails from generating asset files like sass and js for every controller and also stop Rails from creating empty helper files, I mute Rails as follow:
Rails.application.config.generators do |g|
  g.helper false
  g.assets false
  g.view_specs false
end