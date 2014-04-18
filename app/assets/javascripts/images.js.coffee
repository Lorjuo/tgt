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
    cropbox = $('#image\\:\\:banner_file_cropbox')

    coords.x *= cropbox[0].naturalWidth / cropbox.width();
    coords.y *= cropbox[0].naturalHeight / cropbox.height();
    coords.x2 *= cropbox[0].naturalWidth / cropbox.width();
    coords.y2 *= cropbox[0].naturalHeight / cropbox.height();
    coords.w *= cropbox[0].naturalWidth / cropbox.width();
    coords.h *= cropbox[0].naturalHeight / cropbox.height();

    $('#image\\:\\:banner_file_crop_x').val(coords.x)
    $('#image\\:\\:banner_file_crop_y').val(coords.y)
    $('#image\\:\\:banner_file_crop_w').val(coords.w)
    $('#image\\:\\:banner_file_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    previewbox = $('#image\\:\\:banner_file_previewbox')
    previewbox_wrapper = $('#image\\:\\:banner_file_previewbox_wrapper')
    $('#image\\:\\:banner_file_previewbox').css
      width: Math.round(previewbox_wrapper.width() / coords.w * previewbox[0].naturalWidth) + 'px'
      height: Math.round(previewbox_wrapper.height() / coords.h * previewbox[0].naturalHeight) + 'px'
      marginLeft: '-' + Math.round(previewbox_wrapper.width() / coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(previewbox_wrapper.height() / coords.h * coords.y) + 'px'

  # update: (coords) =>
  #   # Escape colons http://stackoverflow.com/questions/5552462/handling-colon-in-element-id-with-jquery
  #   cropbox = $('#image\\:\\:banner_file_cropbox')
  #   coords.x /= cropbox.width()
  #   coords.y /= cropbox.height()
  #   coords.x2 /= cropbox.width()
  #   coords.y2 /= cropbox.height()
  #   coords.w /= cropbox.width()
  #   coords.h /= cropbox.height()

  #   $('#image\\:\\:banner_file_crop_x').val(coords.x)
  #   $('#image\\:\\:banner_file_crop_y').val(coords.y)
  #   $('#image\\:\\:banner_file_crop_w').val(coords.w)
  #   $('#image\\:\\:banner_file_crop_h').val(coords.h)
  #   @updatePreview(coords)

  # updatePreview: (coords) =>
  #   previewbox_wrapper = $('#image\\:\\:banner_file_previewbox_wrapper')
  #   $('#image\\:\\:banner_file_previewbox').css
  #     width: Math.round(previewbox_wrapper.width() / coords.w) + 'px'
  #     height: Math.round(previewbox_wrapper.height() / coords.h) + 'px'
  #     marginLeft: '-' + Math.round(previewbox_wrapper.width() / coords.w * coords.x) + 'px'
  #     marginTop: '-' + Math.round(previewbox_wrapper.height() / coords.h * coords.y) + 'px'
