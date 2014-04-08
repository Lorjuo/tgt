# rake test:all
# rake db:test:prepare

# http://blog.crowdint.com/2013/06/14/testing-rails-with-minitest.html

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)

# Fix: Force ZEUS to not run tests twice
# https://github.com/burke/zeus/issues/269
if ENV.keys.grep(/ZEUS/).any?
  require 'minitest/unit'
  MiniTest::Unit.class_variable_set("@@installed_at_exit", true)
end

require "rails/test_help"
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'minitest/focus'
require 'minitest/colorize'
require "minitest-spec-context"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

# Turn.config do |c|
#  # use one of output formats:
#  # :outline  - turn's original case/test outline mode [default]
#  # :progress - indicates progress with progress bar
#  # :dotted   - test/unit's traditional dot-progress mode
#  # :pretty   - new pretty reporter
#  # :marshal  - dump output as YAML (normal run mode only)
#  # :cue      - interactive testing
#  c.format  = :pretty # https://github.com/turn-project/turn/wiki/Output-Formats
#  # turn on invoke/execute tracing, enable full backtrace
#  c.trace   = true
#  # use humanized test names (works only with :outline format)
#  c.natural = true
#  # c.verbose = true
# end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end
