jQuery ->
  $('.chosen').each ->
    $(this).chosen
      allow_single_deselect: $(this).data( "include-blank" )

#ready = ->
#  $('.chosen').chosen()
#
## Fix for turbolinks
#$(document).ready(ready)
#$(document).on('page:load', ready)
