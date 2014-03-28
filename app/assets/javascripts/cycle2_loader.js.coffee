$ ->
  progress = $(".progressIndicator")
  slideshow = $(".cycle-slideshow")
  slideshow.on "cycle-initialized cycle-before", (e, opts) ->
    progress.stop(true).css "width", 0
    return

  slideshow.on "cycle-initialized cycle-after", (e, opts) ->
    unless slideshow.is(".cycle-paused")
      progress.animate
        width: "100%"
      , opts.timeout, "linear"
    return

  slideshow.on "cycle-paused", (e, opts) ->
    progress.stop()
    return

  slideshow.on "cycle-resumed", (e, opts, timeoutRemaining) ->
    progress.animate
      width: "100%"
    , timeoutRemaining, "linear"
    return
