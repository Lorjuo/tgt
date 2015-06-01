$ ->

  $(".cycle").cycle autoHeight: 1
  $(".cycle2").cycle {}

#https://github.com/kossnocorp/jquery.turbolinks/issues/50#issuecomment-105374415
$(document).on 'page:change', ->
  # Cycle plugin
  $(".previewCycle").cycle(
    #fx: "none"
    speed: 300 # speed of the transition (any valid fx speed value) 
    timeout: 700 # milliseconds between slide transitions (0 to disable auto advance)
    delay: 0 # additional delay (in ms) for first transition (hint: can be negative)
    autoHeight: 1 # probably does not work with jquery turbolinks
    "center-horz": true
    "center-vert": true
  ).cycle(
    "pause"
  ).hover (->
    $(this).cycle(1).cycle "resume"
  ), ->
    $(this).cycle(0).cycle "pause"

  $(window).trigger('resize');
  # Resize event is needed because after turbolinks page refresh the new cycle has a height of 0