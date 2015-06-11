$ ->
  # http://www.eyecon.ro/bootstrap-colorpicker/
  $('input#theme_color.colorpicker').colorpicker().on 'changeColor', (ev) ->
    $('input#theme_color.colorpicker').css('background-color', ev.color.toHex())