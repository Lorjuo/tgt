$.widget 'tgt.cropWidget',
  #options:
    #thumbWidth: 240
    #thumbHeight: 180

  _create: ->
    @cropbox = @element.find('.cropbox')
    @previewbox = @element.find('.previewbox')
    @previewbox_wrapper = @element.find('.previewbox_wrapper')

    @thumbWidth = @element.find('.image-info').data('thumb-width')
    @thumbHeight = @element.find('.image-info').data('thumb-height')

    @cropNatWidth = @cropbox.last().get(0).naturalWidth
    @cropNatHeight = @cropbox.last().get(0).naturalHeight

    self = this
    $(@cropbox).Jcrop
      aspectRatio: @thumbWidth/@thumbHeight # Aspect Ratio width/height of resulting image
      setSelect: [0, 0, @thumbWidth, @thumbHeight] # Initial selection
      # TODO: maybe initialize selection with values stored in crop_x/y/w/h hidden fields
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

    # Set visual output elements
    @element.find('.indicator_crop_x').val((coords.x*100).toFixed(1)+'%' )
    @element.find('.indicator_crop_y').val((coords.y*100).toFixed(1)+'%' )
    @element.find('.indicator_crop_w').val((coords.w*100).toFixed(1)+'%' )
    @element.find('.indicator_crop_h').val((coords.h*100).toFixed(1)+'%' )

    @_updatePreviewHandler(coords)

  # Update preview image
  _updatePreviewHandler: (coords) ->
    width = @previewbox_wrapper.width() / coords.w
    height = @previewbox_wrapper.height() / coords.h

    @previewbox.css
      width: Math.round(width) + 'px'
      height: Math.round(height) + 'px'
      marginLeft: '-' + Math.round(coords.x * width) + 'px'
      marginTop: '-' + Math.round(coords.y * height) + 'px'