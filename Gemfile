source 'https://rubygems.org'
#ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Custom

# Assets
gem 'quiet_assets' # Disable some warnings
# gem "non-stupid-digest-assets" # Because tinymce and elfinder do not work with assets pipeline:
# http://stackoverflow.com/questions/17797962/rails-4-selective-asset-digest

# Colorpicker
gem 'bootstrap-colorpicker-rails'

# CSS
# Bootstrap
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
  # Generator
  # Maybe never needed: Generators by simple form
  #gem 'bootstrap-generators' # Only needed for first installation? - Afterwards it leads to conflicts

# Date
gem 'validates_timeliness'

# Database
gem 'mysql2'
  # Population
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'populator'

# Error Handling
gem 'better_errors'
gem 'binding_of_caller'

# File Upload
gem 'carrierwave'
gem 'jquery-fileupload-rails'
gem 'el_finder'

# Forms
gem 'simple_form'
# gem 'nested_form'
gem 'cocoon'

# Google Maps
gem 'gmaps4rails'
# Does not work with turbolinks
# http://stackoverflow.com/questions/13807686/gmaps4rails-and-turbolinks-not-loading-without-full-page-refresh
gem 'geocoder'
gem 'underscore-rails'

# HTML Abstraction
gem "haml-rails"

# Icons
gem "font-awesome-rails"
# Glyphicons via bootstrap

# Image Processing
gem 'mini_magick'
gem 'fancybox2-rails', '~> 0.2'

# Input Elements
  # Datepicker
  gem 'datetimepicker-rails', :require => 'datetimepicker-rails', :git => 'git://github.com/Lorjuo/datetimepicker-rails.git'
  #gem 'datetimepicker-rails', :require => 'datetimepicker-rails', :path => File.join('..', 'datetimepicker-rails')
  
  # Token Inputs
  gem 'chosen-rails'
  # For Rails 4 project, it is required to add compass-rails gem explicitly.
  gem 'compass-rails', github: 'Compass/compass-rails'

  # gem 'chosen-sass-bootstrap-rails'

# JQuery
gem 'jquery-ui-rails'

# Mail Helpers
gem 'actionview-encoded_mail_to'

# Pagination
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Placeholder
gem 'holder_rails'

# Profiler
gem 'rack-mini-profiler'

# Security
gem 'cancan'
gem 'devise'
gem 'rolify', '~> 3.3.0.rc4' # https://github.com/EppO/rolify/pull/129

# String Operations
gem 'truncate_html'

# Table
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'lodash-rails'
# Alternative: https://github.com/berk/will_filter/wiki/Customizing-Table-View

# Tree Structures
gem 'awesome_nested_set', github: 'huoxito/awesome_nested_set', branch: 'rails4'
gem 'the_sortable_tree'#, '~> 2.3.0'

# Url
gem 'friendly_id' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

# Validators
gem 'valid_email'

# Wizard
gem 'wicked'

# WYSIWYG
gem 'tinymce-rails'
# gem 'tinymce-rails', :git => 'git://github.com/spohlenz/tinymce-rails.git', :branch => 'tinymce-4'
# gem 'tinymce-rails-imageupload'
#gem 'ckeditor', github: 'galetahub/ckeditor'

group :test do
  # gem 'minitest-spec-rails'
  gem 'minitest-rails'
  gem 'minitest-rails-capybara'
  gem 'minitest-colorize'
  gem 'minitest-focus'
  # gem 'minitest-matchers' # NOTE: DO NOT USE THIS - BUT NECESSARY FOR ABILITY TESTING
  gem 'minitest-spec-context'
  gem 'turn'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'


group :development do
  # Use Capistrano for deployment
  # gem 'capistrano', group: :development
  gem 'capistrano', '~> 2.1'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
  
  # Debugger
  gem 'debugger'
  # gem 'byebug'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

# Heroku
gem 'rails_12factor', group: :production
