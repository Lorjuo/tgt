source 'https://rubygems.org'
#ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3' #, '~> 4.0.2'

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

# Cells
gem 'cells'

# Clipboard
#ZeroClipBoardDisabled: gem 'zeroclipboard-rails'

# Cronjobs
gem 'whenever', :require => false

# Colorpicker
gem 'bootstrap-colorpicker-rails'

# CSS
# Bootstrap
gem 'bootstrap-sass'
  # Generator
  # Maybe never needed: Generators by simple form
  #gem 'bootstrap-generators' # Only needed for first installation? - Afterwards it leads to conflicts

# Date
# Following gem is no longer maintained:
# gem 'validates_timeliness',
#   :git => 'git://github.com/yabawock/validates_timeliness.git',
#   :ref => '7f02909'  # Temporary fix to disable deprecation warnings
#   # https://github.com/adzap/validates_timeliness/issues/113
# replaced with:
gem 'jc-validates_timeliness'

# Database
gem 'mysql2'
  gem 'active_record_query_trace'
  # Population
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'populator'

# DRY
# gem 'inherited_resources'

# File Upload
gem 'carrierwave'
gem 'jquery-fileupload-rails', github: 'tors/jquery-fileupload-rails', branch: 'master' # github link needed, because some assets are missing
# Alternative:
# https://github.com/semaperepelitsa/jquery.fileupload-rails
gem 'el_finder'
# Alternatives:
# http://www.roxyfileman.com/
# http://cflove.org/2013/10/coldfusion-file-manager-for-tinymce-4.cfm
# http://www.quivive-file-manager.com
# http://www.responsivefilemanager.com
# http://codecanyon.net/item/tinymce-4-image-manager/4744204
#gem 'jcrop-rails-v2' # carrierwave-crop already contains jcrop
gem 'carrierwave-crop'

# Forms
# http://almassapargali.com/2015/01/15/build-bootstrap-forms-with-simple_form-in-ruby-on-rails.html
gem 'simple_form', '~> 3.1', github: 'plataformatec/simple_form', branch: 'master'
# https://github.com/rafaelfranca/simple_form-bootstrap/blob/master/app/views/examples/_horizontal_form_sf.html.erb
# gem 'nested_form'
gem 'cocoon'

# Google Maps
# Gmaps4RailsDisabled: gem 'gmaps4rails'
# Does not work with turbolinks
# http://stackoverflow.com/questions/13807686/gmaps4rails-and-turbolinks-not-loading-without-full-page-refresh
gem 'geocoder'
gem 'underscore-rails' # needed also for datatables

# HTML Abstraction
gem "haml-rails"

# Icons
gem "font-awesome-rails"
# Glyphicons via bootstrap

# Image Processing
gem 'mini_magick'
gem 'rmagick'
gem 'fancybox2-rails', '~> 0.2'

# Input Elements
  # Datepicker
  gem 'datetimepicker-rails', :require => 'datetimepicker-rails', :git => 'git://github.com/Lorjuo/datetimepicker-rails.git'
  #gem 'datetimepicker-rails', :require => 'datetimepicker-rails', :path => File.join('..', 'datetimepicker-rails')
  
  #gem "jquery_popup_uploader", :path => "../jquery_popup_uploader/" # http://stackoverflow.com/questions/12618927/local-gem-not-working-when-deploying-with-capistrano
  gem "jquery_popup_uploader", :git => "git://github.com/Lorjuo/jquery_popup_uploader.git"
  
  # Token Inputs
  # Chosen check smartphone compatibility. Especially message and training group search
  gem 'chosen-rails'
  # For Rails 4 project, it is required to add compass-rails gem explicitly.
  #gem 'compass-rails', github: 'Compass/compass-rails'
  gem 'compass-rails', '~> 1.1.7'

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

# Server
gem 'unicorn'

# Security
gem 'cancancan'
gem 'devise'
gem 'devise-i18n-views'
gem 'rolify'

# SSH
#gem 'net-ssh', '~> 2.8.1', :git => "https://github.com/net-ssh/net-ssh"
gem 'net-ssh', '~> 2.7.0'
# http://stackoverflow.com/questions/21560297/capistrano-sshauthenticationfailed-not-prompting-for-password

# Social Media

# String Operations
gem 'truncate_html'

# Table
gem 'jquery-datatables-rails'#, git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'lodash-rails'
# Alternative: https://github.com/berk/will_filter/wiki/Customizing-Table-View

# Tree Structures
gem 'awesome_nested_set'#, github: 'huoxito/awesome_nested_set', branch: 'rails4'
gem 'the_sortable_tree'#, '~> 2.3.0'

# Url
gem 'friendly_id' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

# Validators
gem 'email_validator'

# Wakeup
# http://www.mythtv.org/wiki/ACPI_Wakeup

# Wizard
gem 'wicked'

# WYSIWYG
#gem 'tinymce-rails'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
# gem 'tinymce-rails-imageupload'
#gem 'ckeditor', github: 'galetahub/ckeditor'

# TEMPORAL QUICKFIX http://stackoverflow.com/questions/22510461/could-not-find-thread-safe-0-3-0-in-any-of-the-sources
gem 'thread_safe', '0.2.0'

group :test do
  gem 'minitest'
  # gem 'minitest-spec-rails'
  #gem 'minitest-rails' # Disabled because of compatibility issues
  #gem 'minitest-rails-capybara' # Disabled because of compatibility issues
  #gem 'minitest-colorize'
  gem 'minitest-focus'
  # gem 'minitest-matchers' # NOTE: DO NOT USE THIS - BUT NECESSARY FOR ABILITY TESTING
  gem 'minitest-spec-context'
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
  gem 'capistrano', '~> 3.1'

  # rails specific capistrano functions
  gem 'capistrano-rails', '~> 1.1'

  gem 'capistrano-rbenv', '~> 2.0'

  gem 'capistrano3-unicorn'

  gem 'hirb'

  gem "bullet"

  # Annotations
  gem 'annotate'
  
  # Debugger
  #gem 'pry-byebug'
  gem 'debugger'
  # gem 'byebug' # was very slow
  
  #gem "rails-i18n-debug"
  # better:
  #gem 'i18n-debug'
  
  gem 'thin'

  # Error Handling
  gem 'better_errors'
  gem 'binding_of_caller'

  # Source maps
  # http://blog.vhyza.eu/blog/2013/09/22/debugging-rails-4-coffeescript-and-sass-source-files-in-google-chrome/
  #gem 'coffee-rails-source-maps'
  #gem 'sass-rails-source-maps'
end


# Use debugger
# gem 'debugger', group: [:development, :test]

# Heroku
#gem 'rails_12factor', group: :production
# IMPORTANT: This gem serves logging on development server and serves static assets
gem 'rails_12factor', group: [:production, :staging]

# Resources:
# 
# Caching:
# https://www.appneta.com/blog/russian-doll-caching/
# https://github.com/n8/multi_fetch_fragments
# http://www.sitepoint.com/caching-cache-digest/
# https://devcenter.heroku.com/articles/caching-strategies
# http://www.tablexi.com/blog/2013/07/russian-doll-caching-in-rails/developers/
# http://de.slideshare.net/znice/caching-strategies-in-rails-4-25542080
# Why not using fragment caching: http://nicksda.apotomo.de/2011/02/rails-misapprehensions-caching-views-is-not-the-views-job/

# TODO: UTF 8 Problem when copying this message
# http://stackoverflow.com/questions/6115612/how-to-convert-an-entire-mysql-database-characterset-and-collation-to-utf-8
# Probably have to convert database to utf8-unicode-ci
# http://stackoverflow.com/questions/766809/whats-the-difference-between-utf8-general-ci-and-utf8-unicode-ci