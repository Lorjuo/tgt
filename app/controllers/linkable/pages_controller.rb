# encoding: utf-8

module Linkable
  class PagesController < BaseController

    include ::LinkablesController

    def show
      #TODO: maybe move this into a helper
      #for messages also usable
      #
      #http://stackoverflow.com/questions/1274605/ruby-search-file-text-for-a-pattern-and-replace-it-with-a-given-value
      #http://stackoverflow.com/questions/8219169/simple-using-stringscan-to-extract-an-email-address
      #http://stackoverflow.com/questions/16579223/using-named-capture-groups-inside-ruby-gsub-blocks-regex
      #http://stackoverflow.com/questions/11333574/regular-expressions-with-callback-based-upon-match
      #http://stackoverflow.com/questions/8473526/how-to-use-ruby-regexp-to-substitute-string-with-a-callback-function-like-mani

      regex = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
      regex_mailto = /\<a([^>]+)href\=\"mailto\:([^">]+)\"([^>]*)\>.*?\<\/a\>/imu
        caption = view_context.raw '<span class="glyphicon glyphicon-envelope"></span> Email'

      #from = "John Doe <john.doe@daemon.co.uk> John Doe <john.doe@bla.co.uk>";
      #@linkable.content.scan(regex) { |x| puts x };

      @linkable.content = @linkable.content.gsub(regex_mailto) do |match|
        #puts "finding = #{$&}"
        #puts "finding = #{match}"
        #match = view_context.mail_to caption, match, encode: "hex", :class => "email"
        match = view_context.raw(view_context.mail_to($2, caption, encode: "hex", :class => "email"))
      end

      #@linkable.content = @linkable.content.gsub(regex) do |match|
      #  match = view_context.raw(view_context.mail_to(match, caption, encode: "hex", :class => "email"))
      #end
    end

    private

      def resource_params
        params.require(:page).permit(:content, :sidebar,
        :gallery_ids => [], :document_ids => [], :link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
      end

      def resolve_layout
        if @page.present? && !@page.sidebar && params[:action] == 'show'
          'one_column'
        else
          'two_columns'
        end

      end
  end
end