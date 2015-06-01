# File no longer in use because this approach depends on the availability of a form_builder object
# when using cropbox in a ajax form, then there will be no form_builder available

# # encoding: utf-8

# module CarrierWave
#   module Crop
#     module FormBuilder

#       # Form helper to render the preview of a cropped attachment.
#       # Loads the actual image. Previewbox has no constraints on dimensions, image is renedred at full size.
#       # By default box size is 100x100. Size can be customized by setting the :width and :height option.
#       # If you override one of width/height you must override both.
#       # By default original image is rendered. Specific version can be specified by passing version option
#       #
#       #   previewbox :avatar
#       #   previewbox :avatar, width: 200, height: 200
#       #   previewbox :avatar, version: :medium
#       #
#       # @param attachment [Symbol] attachment name
#       # @param opts [Hash] specify version or width and height options
#       def previewbox(attachment, opts = {})
#         attachment = attachment.to_sym

#         if(self.object.send(attachment).class.ancestors.include? CarrierWave::Uploader::Base )
#           ## Fixes Issue #1 : Colons in html id attributes with Namespaced Models
#           model_name = self.object.class.name.downcase.split("::").last 
#           width, height = 100, 100
#           if(opts[:width] && opts[:height])
#             width, height = opts[:width].round, opts[:height].round
#           end
#           if opts[:version]
#             img = self.object.send(attachment).url(opts[:version])
#           else
#             img = self.object.send(attachment).url
#           end

#           #wrapper_attributes = {id: "#{model_name}_#{attachment}_previewbox_wrapper", style: "width:#{width}px; height:#{height}px; overflow:hidden"}
#           wrapper_attributes = {class: "previewbox_wrapper", style: "width:#{width}px; height:#{height}px; overflow:hidden"}
          

#           #preview_image = @template.image_tag(img, id: "#{model_name}_#{attachment}_previewbox")
#           preview_image = @template.image_tag(img, class: "previewbox")
#           @template.content_tag(:div, preview_image, wrapper_attributes)
#         end
#       end

#       # Form helper to render the actual cropping box of an attachment.
#       # Loads the actual image. Cropbox has no constraints on dimensions, image is renedred at full size.
#       # Box size can be restricted by setting the :width and :height option. If you override one of width/height you must override both.
#       # By default original image is rendered. Specific version can be specified by passing version option
#       #
#       #   cropbox :avatar
#       #   cropbox :avatar, width: 550, height: 600
#       #   cropbox :avatar, version: :medium
#       #
#       # @param attachment [Symbol] attachment name
#       # @param opts [Hash] specify version or width and height options
#       def cropbox(attachment, opts={})
#         attachment = attachment.to_sym
#         attachment_instance = self.object.send(attachment)

#         if(attachment_instance.class.ancestors.include? CarrierWave::Uploader::Base )
#           ## Fixes Issue #1 : Colons in html id attributes with Namespaced Models
#           model_name = self.object.class.name.downcase.split("::").last
#           #hidden_elements  = self.hidden_field(:"#{attachment}_crop_x", id: "#{model_name}_#{attachment}_crop_x")
#           hidden_elements = ""
#           [:crop_x, :crop_y, :crop_w, :crop_h].each do |attribute|
#             #hidden_elements << self.hidden_field(:"#{attachment}_#{attribute}", id: "#{model_name}_#{attachment}_#{attribute}")
#             hidden_elements << self.hidden_field(:"#{attachment}_#{attribute}", class: "#{attribute}")
#           end

#           box =  @template.content_tag(:div, hidden_elements, style: "display:none")

#           if opts[:version]
#             img = self.object.send(attachment).url(opts[:version])
#           else
#             img = self.object.send(attachment).url
#           end

#           #wrapper_attributes = {id: "#{model_name}_#{attachment}_cropbox_wrapper"}
#           wrapper_attributes = {class: "cropbox_wrapper"}
#           if(opts[:max_width] && opts[:max_height])
#             width, height = opts[:max_width].round, opts[:max_height].round
#             aspect_ratio = self.object.aspect_ratio
#             if(self.object.aspect_ratio > 1) # landscape format
#               height = opts[:max_height] / aspect_ratio
#             else
#               width = opts[:max_width] * aspect_ratio
#             end
#             wrapper_attributes.merge!(style: "max-width:#{width}px; max-height:#{height}px; overflow:hidden")
#           end

#           #crop_image = @template.image_tag(img, :id => "#{model_name}_#{attachment}_cropbox")
#           #crop_image = @template.image_tag(img, :class => "cropbox", style: "max-width:#{width}px; max-height:#{height}px")
#           crop_image = @template.image_tag(img, :class => "cropbox")
#           box << @template.content_tag(:div, crop_image, wrapper_attributes)
#         end
#       end
#     end
#   end
# end

# if defined? ActionView::Helpers::FormBuilder
#   ActionView::Helpers::FormBuilder.class_eval do
#     include CarrierWave::Crop::FormBuilder
#   end
# end