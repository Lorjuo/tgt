# jQuery Boilerplate - v3.3.4
# https://github.com/jquery-boilerplate/jquery-boilerplate/blob/master/src/jquery.boilerplate.coffee
# https://github.com/jquery-boilerplate/jquery-boilerplate/blob/master/dist/jquery.boilerplate.js

# Note that when compiling with coffeescript, the plugin is wrapped in another
# anonymous function. We do not need to pass in undefined as well, since
# coffeescript uses (void 0) instead.
do ($ = jQuery, window, document) ->

    # window and document are passed through as local variable rather than global
    # as this (slightly) quickens the resolution process and can be more efficiently
    # minified (especially when both are regularly referenced in your plugin).

    # Create the defaults once
    pluginName = "seatReservation"
    defaults =
        seatMap: "a1,a2\na3,a4"
        occupied: []
        selected: [] #var js_array = [<%= raw @object.to_json %>];

    # The actual plugin constructor
    class Plugin

        constructor: (@element, options) ->
            # jQuery has an extend method which merges the contents of two or
            # more objects, storing the result in the first object. The first object
            # is generally empty as we don't want to alter the default options for
            # future instances of the plugin
            @settings = $.extend {}, defaults, options
            @_defaults = defaults
            @_name = pluginName
            @init()

        init: ->
            # Place initialization logic here
            # You already have access to the DOM element and the options via the instance,
            # e.g., @element and @settings
            console.log "xD"
            plugin = this
            # Maybe move this line to class Plugin
            # maybe you need to add plugin.prototype

            # Create HTML DOM: https://coderwall.com/p/evmqoa
            seatMapList = $('<div>', {class: 'seatReservation'})
            $(@element).after seatMapList

            @occupied = @settings.occupied
            @selected = @settings.selected

            @element.value = @selected.join(',')

            # Each: http://stackoverflow.com/questions/9329446/how-to-do-for-each-over-an-array-in-javascript
            rows = @settings.seatMap.split("\n")
            $.each rows, ->
                seatMapRow = $('<div>', {class: 'seatRow'})
                cols = this.split(",")
                $.each cols, ->
                    if this.trim() == '-'
                        seatMapElement = $('<div>', {class: 'seat empty'})
                    else
                        category = this[0]
                        index = parseInt(this.substring(1))
                        #index = this.substring(1)#.trim()
                        seatMapElement = $('<div>', {class: 'seat category category'+category.toUpperCase()})
                        seatMapElement.append $('<span>', {class: 'border'})
                        seatMapElement.append $('<span>', {class: 'indicator'})


                        if $.inArray(index, plugin.selected) != -1
                            seatMapElement.addClass('selected')

                        if $.inArray(index, plugin.occupied) != -1
                            seatMapElement.addClass('occupied')
                        else
                            seatMapElement.bind "click", ->
                                # plugin.seatClicked($(this).data('seat-id'))
                                plugin.seatClicked(index, !seatMapElement.hasClass('selected'))
                                seatMapElement.toggleClass('selected', 500)

                    $(seatMapRow).append seatMapElement
                $(seatMapList).append seatMapRow

        seatClicked: (seatId, selected) ->
            #alert(seatId)
            if selected
                @selected.push(seatId)
                @selected.sort (a, b) ->
                    a - b
            else
                @selected = jQuery.grep(@selected, (value) ->
                  value isnt seatId
                )
            @element.value = @selected.join(',')

        yourOtherFunction: ->
            # some logic

    # A really lightweight plugin wrapper around the constructor,
    # preventing against multiple instantiations
    $.fn[pluginName] = (options) ->
        @each ->
            unless $.data @, "plugin_#{pluginName}"
                $.data @, "plugin_#{pluginName}", new Plugin @, options
$ ->
    $("input.seats").seatReservation {seatMap: "-,-,a1,a2,a3,a4,a5,a6\na7,a8,a9,a10,-,-,a11,a12\nb13,b14,-,-,-,-,b15,b16\nc5,c6,d7", occupied: [1,3], selected: [2,4]}