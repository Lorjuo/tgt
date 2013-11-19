# require 'active_support/core_ext/hash/keys'

module TinyMCE::Rails
  module Helper
    # Initializes TinyMCE on the current page based on the global configuration.
    #
    # Custom options can be set via the options hash, which will be passed to
    # the TinyMCE init function.
    #
    # By default, all textareas with a class of "tinymce" will have the TinyMCE
    # editor applied. The current locale will also be used as the language when
    # TinyMCE language files are available, falling back to English if not
    # available. The :editor_selector and :language options can be used to
    # override these defaults.
    #
    # @example
    #   <%= tinymce(:theme => "advanced", :editor_selector => "editorClass") %>
    # def tinymce(config=:default, options={})
    #   javascript_tag { tinymce_javascript(config, options) }
    # end
    
    # Returns the JavaScript code required to initialize TinyMCE.
    def tinymce_javascript(config=:default, options={})
      json = tinymce_configuration(config, options).to_json
      json = json.gsub('"elFinderBrowser"', 'elFinderBrowser')
      json = json[0..-2]
      json += ",\"template_replace_values\": {"\
        "\"size\": function() {return window.prompt('Größe der Box (\"small\", \"medium\"=default, \"large\",\"full\")');},"\
        "\"align\": function() {return window.prompt('Ausrichtung der Box (\"left\", \"right\")');},"\
        "\"title\": function() {return window.prompt(\"Titel\");},"\
        "\"description\": function() {return window.prompt(\"Beschreibung\");}"\
      "}"
      json += ",\"content_css\" : \""+path_to_stylesheet('application')+","+path_to_stylesheet('wysiwyg')+"\""
      json += "}"
      "tinyMCE.init(#{json});".html_safe

    end
    
    # Returns the TinyMCE configuration as a hash.
    # It should be converted to JSON (via #to_json) for use within JavaScript.
    # def tinymce_configuration(config=:default, options={})
    #   options, config = config, :default if config.is_a?(Hash)
    #   options.stringify_keys!
      
    #   base_configuration = TinyMCE::Rails.configuration
      
    #   if base_configuration.is_a?(MultipleConfiguration)
    #     base_configuration = base_configuration.fetch(config)
    #   end
    #   debugger
      
    #   base_configuration.merge(options).options_for_tinymce
    # end
    
    # Includes TinyMCE javascript assets via a script tag.
    # def tinymce_assets
    #   javascript_include_tag "tinymce"
    # end
  end
end
