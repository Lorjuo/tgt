require File.expand_path('../boot', __FILE__)

require 'rails/all'

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
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Custom
    
    # Autoload Paths
    config.autoload_paths += %W(#{config.root}/lib)

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

    config.assets.precompile += %w(
      tinymce/themes/advanced/skins/bootstrap/ui.css
      tinymce/themes/advanced/skins/bootstrap/content.css
    )
    # + %w(
    #   elfinder/elfinder.min.css
    #   elfinder/theme.css
    #   elfinder/elfinder.min.js
    #   elfinder/proxy/elFinderSupportVer1.js
    # )
    
    # Quick fix for colorpicker:
    # https://github.com/alessani/bootstrap-colorpicker-rails/pull/11
    config.assets.precompile += %w(
      alpha.png
      hue.png
      saturation.png
      bootstrap-colorpicker.js
      bootstrap-colorpicker.css
    )
    # Quick fix for fancybox:
    # https://github.com/kyparn/fancybox2-rails/issues/10
    config.assets.precompile += %w( blank.gif fancybox_buttons.png fancybox_loading.gif fancybox_loading@2x.gif fancybox_overlay.png fancybox_sprite.png fancybox_sprite@2x.png )
    # config.assets.precompile += ['tinymce/*']
    config.assets.precompile += ['elfinder/*']
    # config.assets.precompile += %w[tinymce/tiny_mce.js tinymce/langs/en.js tinymce/themes/advanced/editor_template.js]
    
    # Internationalization
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
  end
end
