ready = ->
  $('.chosen').chosen()

# Fix for turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
