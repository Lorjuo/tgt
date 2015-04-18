jQuery ->
  new CarrierWaveCropper('banner')
  new CarrierWaveCropper('header')
  new CarrierWaveCropper('galleryimage')

class CarrierWaveCropper
  constructor: (identifier) ->
    @identifier = identifier

    width = $('#dimensions').data('width')
    height = $('#dimensions').data('height')
    $(@identifier_id('_file_cropbox')).Jcrop

      aspectRatio: width/height # Aspect Ratio width/height of resulting image
      setSelect: [0, 0, width, height] # Initial selection
      onSelect: @update
      onChange: @update

  update: (coords) =>
    # Escape colons http://stackoverflow.com/questions/5552462/handling-colon-in-element-id-with-jquery
    cropbox = $(@identifier_id('_file_cropbox'))

    coords.x *= cropbox[0].naturalWidth / cropbox.width();
    coords.y *= cropbox[0].naturalHeight / cropbox.height();
    coords.x2 *= cropbox[0].naturalWidth / cropbox.width();
    coords.y2 *= cropbox[0].naturalHeight / cropbox.height();
    coords.w *= cropbox[0].naturalWidth / cropbox.width();
    coords.h *= cropbox[0].naturalHeight / cropbox.height();

    $(@identifier_id('_file_crop_x')).val(coords.x)
    $(@identifier_id('_file_crop_y')).val(coords.y)
    $(@identifier_id('_file_crop_w')).val(coords.w)
    $(@identifier_id('_file_crop_h')).val(coords.h)
    $(@identifier_id('_indicator_crop_x')).val(coords.x.toFixed(2) )
    $(@identifier_id('_indicator_crop_y')).val(coords.y.toFixed(2) )
    $(@identifier_id('_indicator_crop_w')).val(coords.w.toFixed(2) )
    $(@identifier_id('_indicator_crop_h')).val(coords.h.toFixed(2) )
    @updatePreview(coords)

  updatePreview: (coords) =>
    previewbox = $(@identifier_id('_file_previewbox'))
    previewbox_wrapper = $(@identifier_id('_file_previewbox_wrapper'))
    $(@identifier_id('_file_previewbox')).css
      width: Math.round(previewbox_wrapper.width() / coords.w * previewbox[0].naturalWidth) + 'px'
      height: Math.round(previewbox_wrapper.height() / coords.h * previewbox[0].naturalHeight) + 'px'
      marginLeft: '-' + Math.round(previewbox_wrapper.width() / coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(previewbox_wrapper.height() / coords.h * coords.y) + 'px'

  identifier_id: (element) =>
    '#' + @identifier + element

  # For relative coordinates:
  # update: (coords) =>
  #   # Escape colons http://stackoverflow.com/questions/5552462/handling-colon-in-element-id-with-jquery
  #   cropbox = $(@identifier_id('_file_cropbox'))
  #   coords.x /= cropbox.width()
  #   coords.y /= cropbox.height()
  #   coords.x2 /= cropbox.width()
  #   coords.y2 /= cropbox.height()
  #   coords.w /= cropbox.width()
  #   coords.h /= cropbox.height()

  #   $(@identifier_id('_file_crop_x')).val(coords.x)
  #   $(@identifier_id('_file_crop_y')).val(coords.y)
  #   $(@identifier_id('_file_crop_w')).val(coords.w)
  #   $(@identifier_id('_file_crop_h')).val(coords.h)
  #   @updatePreview(coords)

  # updatePreview: (coords) =>
  #   previewbox_wrapper = $(@identifier_id('_file_previewbox_wrapper'))
  #   $(@identifier_id('_file_previewbox')).css
  #     width: Math.round(previewbox_wrapper.width() / coords.w) + 'px'
  #     height: Math.round(previewbox_wrapper.height() / coords.h) + 'px'
  #     marginLeft: '-' + Math.round(previewbox_wrapper.width() / coords.w * coords.x) + 'px'
  #     marginTop: '-' + Math.round(previewbox_wrapper.height() / coords.h * coords.y) + 'px'
