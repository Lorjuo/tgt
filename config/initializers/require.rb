# http://stackoverflow.com/questions/19098663/auto-loading-lib-files-in-rails-4
# Another place would be application.rb
# 
require "#{Rails.root}/lib/carrierwave/crop/form_builder.rb"
require "#{Rails.root}/lib/carrierwave/crop/form_tag_helper.rb"
require "#{Rails.root}/lib/carrierwave/crop/model_additions.rb"