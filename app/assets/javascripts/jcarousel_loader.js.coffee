(($) ->
  
  # This is the connector function.
  # It connects one item from the navigation carousel to one item from the
  # stage carousel.
  # The default behaviour is, to connect items with the same index from both
  # carousels. This might _not_ work with circular carousels!
  connector = (itemNavigation, carouselStage) ->
    carouselStage.jcarousel("items").eq itemNavigation.index()

  $ ->
    
    # Setup the carousels. Adjust the options for both carousels here.
    carouselStage = $(".carousel-stage")

    # http://sorgalla.com/jcarousel/docs/cookbook/responsive-carousel.html
    carouselStage.on("jcarousel:create jcarousel:reload", ->
      element = $(this)
      width = element.innerWidth()
      element.jcarousel("items").css "width", width + "px"
    )

    carouselStage.jcarousel(
      wrap: "circular"
    )

    carouselStage.jcarouselAutoscroll(
      interval: 5000
      target: "+=1"
      autostart: true
    )

    # Disable Autoscroll on hover
    # https://github.com/jsor/jcarousel/issues/568
    # Coffee Conversion: http://stackoverflow.com/questions/9917441/how-to-code-comma-separated-functions-inside-jquery-event-into-coffeescript
    # TODO: Bug with control hover
    carouselStage.hover(
      ->
        $(this).jcarouselAutoscroll "stop"
      ,->
        $(this).jcarouselAutoscroll "start"
    )

    # Enable Mousewheel
    # http://stackoverflow.com/questions/5659793/jquery-jcarousel-not-lite-and-mousewheel-need-help
    # TODO: Bug with control hover
    carouselStage.mousewheel (event, delta) ->
      event.preventDefault()
      if delta > 0
        $(this).jcarousel('scroll', '-=1')
      else $(this).jcarousel('scroll', '+=1')if delta < 0

    carouselNavigation = $(".carousel-navigation").jcarousel(vertical: true)
    
    # We loop through the items of the navigation carousel and set it up
    # as a control for an item from the stage carousel.
    carouselNavigation.jcarousel("items").each ->
      item = $(this)
      
      # This is where we actually connect to items.
      target = connector(item, carouselStage)
      item.on("jcarouselcontrol:active", ->
        carouselNavigation.jcarousel "scrollIntoView", this
        item.addClass "active"
      ).on("jcarouselcontrol:inactive", ->
        item.removeClass "active"
      ).jcarouselControl
        target: target
        carousel: carouselStage

    # Enable Mousewheel
    # http://stackoverflow.com/questions/5659793/jquery-jcarousel-not-lite-and-mousewheel-need-help
    carouselNavigation.mousewheel (event, delta) ->
      event.preventDefault()
      if delta > 0
        $(this).jcarousel('scroll', '-=1')
      else $(this).jcarousel('scroll', '+=1')if delta < 0

    
    # Setup controls for the stage carousel
    $(".prev-stage").on("jcarouselcontrol:inactive", ->
      $(this).addClass "inactive"
    ).on("jcarouselcontrol:active", ->
      $(this).removeClass "inactive"
    ).jcarouselControl target: "-=1"
    $(".next-stage").on("jcarouselcontrol:inactive", ->
      $(this).addClass "inactive"
    ).on("jcarouselcontrol:active", ->
      $(this).removeClass "inactive"
    ).jcarouselControl target: "+=1"
    
    # Setup controls for the navigation carousel
    $(".prev-navigation").on("jcarouselcontrol:inactive", ->
      $(this).addClass "inactive"
    ).on("jcarouselcontrol:active", ->
      $(this).removeClass "inactive"
    ).jcarouselControl target: "-=1"
    $(".next-navigation").on("jcarouselcontrol:inactive", ->
      $(this).addClass "inactive"
    ).on("jcarouselcontrol:active", ->
      $(this).removeClass "inactive"
    ).jcarouselControl target: "+=1"

) jQuery