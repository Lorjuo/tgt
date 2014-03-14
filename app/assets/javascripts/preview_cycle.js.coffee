jQuery ->

  $(".cycle").cycle autoHeight: 1
  $(".cycle2").cycle {}
  
  # Cycle plugin
  $(".preview_cycle").cycle(
    #fx: "none"
    speed: 500 # speed of the transition (any valid fx speed value) 
    timeout: 500 # milliseconds between slide transitions (0 to disable auto advance)
    delay: -1000 # additional delay (in ms) for first transition (hint: can be negative)
    autoHeight: 1
    "center-horz": true
    "center-vert": true
  ).cycle(
    "pause"
  ).hover (->
    $(this).cycle "resume"
  ), ->
    $(this).cycle(0).cycle "pause"