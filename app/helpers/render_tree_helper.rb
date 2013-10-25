# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        "
          <li class=\"dropdown\">
            #{ show_link }
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]

        h.link_to(node.send(title_field), url)
        #h.link_to(node.send(title_field), url, :class => "dropdown-toggle", :data => {:toggle => "dropdown"})#+h.tag(:b, :class => "caret")
      end

      def children
        unless options[:children].blank?
          "<ul class=\"dropdown-menu\">#{ options[:children] }</ul>"
        end
      end

    end
  end
end