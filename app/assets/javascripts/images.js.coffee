jQuery ->
  new CarrierWaveCropper()

class CarrierWaveCropper
  constructor: ->
    $('#image\\:\\:banner_file_cropbox').Jcrop
      aspectRatio: 4 # Aspect Ratio width/height of resulting image
      setSelect: [0, 0, 100, 400] # Initial selection
      onSelect: @update
      onChange: @update

  update: (coords) =>
    # Escape colons http://stackoverflow.com/questions/5552462/handling-colon-in-element-id-with-jquery
    $('#image\\:\\:banner_file_crop_x').val(coords.x)
    $('#image\\:\\:banner_file_crop_y').val(coords.y)
    $('#image\\:\\:banner_file_crop_w').val(coords.w)
    $('#image\\:\\:banner_file_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    #preview_wrapper = $('#image\\:\\:banner_file_previewbox_wrapper')
    $('#image\\:\\:banner_file_previewbox').css
      width: Math.round(400/coords.w * $('#image\\:\\:banner_file_cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#image\\:\\:banner_file_cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(400/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
