require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Pick the frameworks you want:
# http://blog.crowdint.com/2013/06/14/testing-rails-with-minitest.html
# require "active_record/railtie"
# require "action_controller/railtie"
# require 'rake/testtask'
# require "action_mailer/railtie"
# # require "active_resource/railtie"
# require "sprockets/railtie"
# require "minitest/rails/railtie"
# # require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TgtRefurbished
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.enforce_available_locales = true # do this before default_locale
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Custom
    
    # Autoload Paths
    config.autoload_paths += Dir["#{config.root}/lib/"]
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += Dir["#{Rails.root}/app/models/**/"] # For namespacing

    # Set the default template engine
    config.generators do |g| 
      g.template_engine :erb 
    end


    # Pagination
    # set per_page globally
    WillPaginate.per_page = 10

    # Only for debugging
    #config.action_controller.permit_all_parameters = true
    
    #https://github.com/harleyttd/miniprofiler
    Rack::MiniProfiler.config.authorization_mode = :whitelist #if Rails.env.production? #behaviour handled by config.yml
    Rack::MiniProfiler.config.start_hidden = true #Toggle with Alt+P

    config.generators do |g|
      g.test_framework :mini_test, :spec => true, :fixture => false
      g.fixture_replacement :factory_girl, :dir => "test/factories"
    end

    # Precompilation
    config.assets.precompile += %w(
      elfinder/elfinder.min.css
      elfinder/theme.css
      elfinder/elfinder.min.js
      elfinder/proxy/elFinderSupportVer1.js
      wysiwyg.css
      *-bundle.js
    )
    # http://blog.seancarpenter.net/2012/11/05/page-specific-javascript-with-the-asset-pipeline/
    # http://brandonhilkert.com/blog/page-specific-javascript-in-rails/
    
    # Internationalization
    config.i18n.enforce_available_locales = false #http://stackoverflow.com/questions/20361428/rails-i18n-validation-deprecation-warning
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
    # http://stackoverflow.com/questions/20361428/rails-i18n-validation-deprecation-warning
    # 
    #ActiveRecordQueryTrace.enabled = true
    #ActiveRecordQueryTrace.level = :full
    #ActiveRecordQueryTrace.lines = 0
  end
end
