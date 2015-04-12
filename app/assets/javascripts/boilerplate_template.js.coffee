# jQuery Plugin Boilerplate
# A boilerplate for jumpstarting jQuery plugins development
# version 2.0, July 8th, 2011
# by Stefan Gabos
$ ->

  $.pluginName = (el, options) ->
    defaults =
      propertyName: 'value'
      onSomeEvent: ->
        # do something / callback

    plugin = this
    plugin.settings = {}

    init = ->
      plugin.settings = $.extend({}, defaults, options)
      plugin.el = el
      # code goes here

    plugin.foo_public_method = ->
      # code goes here

    foo_private_method = ->
      # code goes here

    init()