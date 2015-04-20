$.widget 'tgt.cropWidget',
  options:
    thumbWidth: 544
    thumbHeight: 74

  _create: ->
    @cropbox = @element.find('.cropbox')
    @previewbox = @element.find('.previewbox')
    @previewbox_wrapper = @element.find('.previewbox_wrapper')

    @cropNatWidth = @cropbox.get(0).naturalWidth
    @cropNatHeight = @cropbox.get(0).naturalHeight
    #@prevNatWidth = @previewbox.get(0).naturalWidth
    #@prevNatHeight = @previewbox.get(0).naturalHeight

    self = this
    $(@cropbox).Jcrop
      aspectRatio: @options.thumbWidth/@options.thumbHeight # Aspect Ratio width/height of resulting image
      setSelect: [0, 0, @options.thumbWidth, @options.thumbHeight] # Initial selection
      #onSelect: @_updateHandler
      #onChange: @_updateHandler
      #onSelect: self._updateHandler
      #onChange: self._updateHandler
      #onSelect: self._trigger('open')
      #onChange: self._trigger('open')
      onSelect: $.proxy(self._updateHandler, self)
      onChange: $.proxy(self._updateHandler, self)
      trueSize: [@cropNatWidth,@cropNatHeight]

  # http://stackoverflow.com/questions/10941067/how-to-use-this-and-this-fat-arrow-using-coffeescript
  # http://stackoverflow.com/questions/5490448/how-do-i-pass-the-this-context-into-an-event-handler
  # http://stackoverflow.com/questions/12648187/coffeescript-how-to-use-both-fat-arrow-and-this
  # http://stackoverflow.com/questions/7890300/connecting-a-jquery-ui-callback-to-its-handler-class
  # http://stackoverflow.com/questions/24540478/coffeescript-this-is-always-replaced-by-this-in-fat-arrow-callback
  # http://stackoverflow.com/questions/25388988/jquery-widget-factory-access-options-in-a-callback-method
  # http://blog.revathskumar.com/2013/10/coffeescript-avoid-using-jquery-proxy-and-bind-this.html
  # http://stackoverflow.com/questions/25388988/jquery-widget-factory-access-options-in-a-callback-method
  # http://stackoverflow.com/questions/11078845/how-to-access-this-inside-my-custom-jquery-widget-callback
  # http://www.erichynds.com/blog/tips-for-developing-jquery-ui-widgets
  
  # double arrow, because we need access to "this" resp. "@"
  #_updateHandler: (coords) =>
  _updateHandler: (coords) ->

    @element.find('.crop_x').val(coords.x)
    @element.find('.crop_y').val(coords.y)
    @element.find('.crop_w').val(coords.w)
    @element.find('.crop_h').val(coords.h)

    # convert to relative (percentage) values
    coords.x /= @cropNatWidth
    coords.y /= @cropNatHeight
    coords.x2 /= @cropNatWidth
    coords.y2 /= @cropNatHeight
    coords.w /= @cropNatWidth
    coords.h /= @cropNatHeight

    # Cropbox may be scaled to fit in the form
    # Therefore the coordinates need to be scaled to fit in the box
    #horizontalScaling = @cropNatWidth / @thumbWidth
    #verticalScaling = @cropNatHeight / @thumbHeight
    # Get(0) needed to get unterlaying DOM object instead of wrapped jquery object

    # coords.x *= horizontalScaling
    # coords.y *= verticalScaling
    # coords.x2 *= horizontalScaling
    # coords.y2 *= verticalScaling
    # coords.w *= horizontalScaling
    # coords.h *= verticalScaling

    @element.find('.indicator_crop_x').val((coords.x*100).toFixed(4)+'%' )
    @element.find('.indicator_crop_y').val((coords.y*100).toFixed(4)+'%' )
    @element.find('.indicator_crop_w').val((coords.w*100).toFixed(4)+'%' )
    @element.find('.indicator_crop_h').val((coords.h*100).toFixed(4)+'%' )

    @_updatePreviewHandler(coords)

  _updatePreviewHandler: (coords) ->
    # horizontalScaling = @thumbWidth / @previewbox_wrapper.width()
    # verticalScaling = @thumbHeight / @previewbox_wrapper.height()

    # coords.x *= horizontalScaling / 100
    # coords.y *= verticalScaling / 100
    # coords.x2 *= horizontalScaling / 100
    # coords.y2 *= verticalScaling / 100
    # coords.w *= horizontalScaling / 100
    # coords.h *= verticalScaling / 100
    
    # coords.x *= @previewbox.width()
    # coords.y *= @previewbox.height()
    # coords.x2 *= @previewbox.width()
    # coords.y2 *= @previewbox.height()
    # coords.w *= @previewbox.width()
    # coords.h *= @previewbox.height()

    # @previewbox.css
    #   width: Math.round(coords.w) + 'px'
    #   height: Math.round(coords.h) + 'px'
    #   marginLeft: '-' + Math.round(coords.x) + 'px'
    #   marginTop: '-' + Math.round(coords.y) + 'px'
    #   
    #if parseInt(coords.w) > 0
    width = @previewbox_wrapper.width() / coords.w
    height = @previewbox_wrapper.height() / coords.h

    @previewbox.css
      width: Math.round(width) + 'px'
      height: Math.round(height) + 'px'
      marginLeft: '-' + Math.round(coords.x * width) + 'px'
      marginTop: '-' + Math.round(coords.y * height) + 'px'



$ ->
  $('.crop-widget')
    .cropWidget({ 'aspect-ratio': 16/9 });

# $.widget 'custom.progressbar',
#   options: value: 0
#   _create: ->
#     @options.value = @_constrain(@options.value)
#     @element.addClass 'progressbar'
#     @refresh()
#     return
#   _setOption: (key, value) ->
#     if key == 'value'
#       value = @_constrain(value)
#     @_super key, value
#     return
#   _setOptions: (options) ->
#     @_super options
#     @refresh()
#     return
#   refresh: ->
#     progress = @options.value + '%'
#     @element.text progress
#     if @options.value == 100
#       @_trigger 'complete', null, value: 100
#     return
#   _constrain: (value) ->
#     if value > 100
#       value = 100
#     if value < 0
#       value = 0
#     value
#   _destroy: ->
#     @element.removeClass('progressbar').text ''
#     return