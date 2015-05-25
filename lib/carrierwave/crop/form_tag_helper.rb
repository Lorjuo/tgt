# encoding: utf-8

require "action_view"

module CarrierWave
  module Crop
    module FormTagHelper
      # Form helper to render the preview of a cropped attachment.
      # Loads the actual image. Previewbox has no constraints on dimensions, image is renedred at full size.
      # By default box size is 100x100. Size can be customized by setting the :width and :height option.
      # If you override one of width/height you must override both.
      # By default original image is rendered. Specific version can be specified by passing version option
      #
      #   previewbox :avatar
      #   previewbox :avatar, width: 200, height: 200
      #   previewbox :avatar, version: :medium
      #
      # @param attachment [Symbol] attachment name
      # @param opts [Hash] specify version or width and height options
      def previewbox(object, attachment, opts = {})
        attachment = attachment.to_sym

        if(object.send(attachment).class.ancestors.include? CarrierWave::Uploader::Base )
          ## Fixes Issue #1 : Colons in html id attributes with Namespaced Models
          model_name = object.class.name.downcase.split("::").last 
          width, height = 100, 100
          if(opts[:width] && opts[:height])
            width, height = opts[:width].round, opts[:height].round
          end
          if opts[:version]
            img = object.send(attachment).url(opts[:version])
          else
            img = object.send(attachment).url
          end

          #wrapper_attributes = {id: "#{model_name}_#{attachment}_previewbox_wrapper", style: "width:#{width}px; height:#{height}px; overflow:hidden"}
          wrapper_attributes = {class: "previewbox_wrapper", style: "width:#{width}px; height:#{height}px; overflow:hidden"}
          

          #preview_image = @template.image_tag(img, id: "#{model_name}_#{attachment}_previewbox")
          preview_image = image_tag(img, class: "previewbox")
          content_tag(:div, preview_image, wrapper_attributes)
        end
      end

      # Form helper to render the actual cropping box of an attachment.
      # Loads the actual image. Cropbox has no constraints on dimensions, image is renedred at full size.
      # Box size can be restricted by setting the :width and :height option. If you override one of width/height you must override both.
      # By default original image is rendered. Specific version can be specified by passing version option
      #
      #   cropbox :avatar
      #   cropbox :avatar, width: 550, height: 600
      #   cropbox :avatar, version: :medium
      #
      # @param attachment [Symbol] attachment name
      # @param opts [Hash] specify version or width and height options
      def cropbox(object, attachment, opts={})
        attachment = attachment.to_sym
        attachment_instance = object.send(attachment)

        if(attachment_instance.class.ancestors.include? CarrierWave::Uploader::Base )
          ## Fixes Issue #1 : Colons in html id attributes with Namespaced Models
          model_name = object.class.name.downcase.split("::").last
          #hidden_elements  = self.hidden_field(:"#{attachment}_crop_x", id: "#{model_name}_#{attachment}_crop_x")
          hidden_elements = ""
          [:crop_x, :crop_y, :crop_w, :crop_h].each do |attribute|
            #hidden_elements << self.hidden_field(:"#{attachment}_#{attribute}", id: "#{model_name}_#{attachment}_#{attribute}")
            #hidden_elements << self.hidden_field(:"#{attachment}_#{attribute}", class: "#{attribute}")
            hidden_elements << hidden_field_tag(:"#{attachment}_#{attribute}", '', class: "#{attribute}")
          end

          box = content_tag(:div, hidden_elements, style: "display:none")

          if opts[:version]
            img = object.send(attachment).url(opts[:version])
          else
            img = object.send(attachment).url
          end

          #wrapper_attributes = {id: "#{model_name}_#{attachment}_cropbox_wrapper"}
          wrapper_attributes = {class: "cropbox_wrapper"}
          if(opts[:max_width] && opts[:max_height])
            width, height = opts[:max_width].round, opts[:max_height].round
            aspect_ratio = object.aspect_ratio
            if(object.aspect_ratio > opts[:max_width].to_f / opts[:max_height].to_f) # landscape format
              height = (opts[:max_width].to_f / aspect_ratio).round
            else
              width = (opts[:max_height].to_f * aspect_ratio).round
            end
            # maybe use max-width/height
            wrapper_attributes.merge!(style: "width:#{width}px; height:#{height}px; overflow:hidden")
          end

          #crop_image = @template.image_tag(img, :id => "#{model_name}_#{attachment}_cropbox")
          #crop_image = @template.image_tag(img, :class => "cropbox", style: "max-width:#{width}px; max-height:#{height}px")
          crop_image = image_tag(img, :class => "cropbox", style: "width:#{width}px; height:#{height}px")
          box << content_tag(:div, crop_image, wrapper_attributes)
        end
      end
    end
  end
end

# Best way to make this accessible as helper method:
# https://github.com/NARKOZ/holder_rails/blob/master/lib/holder_rails/helpers.rb
ActionView::Base.send :include, CarrierWave::Crop::FormTagHelper

# Alternative: https://github.com/kirtithorat/carrierwave
# if defined? ActionView::Helpers::FormTagHelper
#   ActionView::Helpers::FormTagHelper.class_eval do
#     #debugger
#     include CarrierWave::Crop::FormTagHelper
#   end
# end


# Unused alternatives:
# http://stackoverflow.com/questions/16720514/how-to-use-url-helpers-in-lib-modules-and-set-host-for-multiple-environments
# https://codeclimate.com/github/instructure/canvas-lms/I18nUtilities
# http://stackoverflow.com/questions/13532620/understanding-ruby-on-rails-sendinclude
# http://stackoverflow.com/questions/2623250/custom-form-helpers
# https://github.com/Verba/date-input-rails/blob/master/lib/date-input-rails.rb
# https://www.omniref.com/ruby/gems/date-input-rails/0.0.2/symbols/DateInputRails#line=6
# http://stackoverflow.com/questions/2128114/add-a-form-helper-method
# http://rubyjunction.us/how-to-add-a-datepicker-in-rails
# http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html
# https://github.com/pitr/angular-rails-templates/issues/45
# http://stackoverflow.com/questions/16864959/how-to-add-override-method-to-helper
# https://github.com/greatseth/labeling-form-helper
# http://blog.lrdesign.com/2011/04/extending-form_for-in-rails-3-with-your-own-methods/
# http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/
# http://timelessrepo.com/block-helpers-in-rails3
# http://reefpoints.dockyard.com/ruby/2012/02/14/love-your-lib-directory.html
# http://stackoverflow.com/questions/3063256/ruby-on-rails-global-helper-method-for-all-controllers
# http://railscasts.com/episodes/132-helpers-outside-views?view=comments
# http://railscasts.com/episodes/64-custom-helper-modules?view=comments
# http://apidock.com/rails/ActionView/Helpers/TagHelper
# http://adamhooper.com/eng/articles/2-working-with-and-around-formbuilder