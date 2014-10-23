# $(document).ready ->
# jQuery ->
$ ->
# $(document).on "page:load", ->
# TODO: Problem with backwards button in browser
  $(".fancybox").fancybox
    helpers:
      title:
        type: "outside"

      thumbs:
        width: 50
        height: 30

    beforeLoad: ->
      @title = $(@element).attr("caption")

    # onUpdate: ->
    #   $("#fancybox-thumbs ul").draggable axis: "x"
    #   posXY = ""
    #   $(".fancybox-skin").draggable
    #     axis: "x"
    #     drag: (event, ui) ->
          
    #       # get position
    #       posXY = ui.position.left
          
    #       # if drag distance bigger than +- 100px: cancel drag function..
    #       return false  if posXY > 100
    #       false  if posXY < -100

    #     stop: ->
          
    #       # ... and get next or previous image
    #       $.fancybox.prev()  if posXY > 95
    #       $.fancybox.next()  if posXY < -95
    #       
      # #Enable swiping...
      # $("#test").swipe
        
      #   #Generic swipe handler for all directions
      #   swipeLeft: (event, direction, distance, duration, fingerCount) ->
      #     $(this).text "You swiped " + direction + " " + ++count + " times "
      #   #Default is 75px, set to 0 for demo so any distance triggers swipe
      #   threshold: 0
    
    onUpdate: ->
      #$("#fancybox-thumbs ul").swipe # this element is just 0px heigh
      $(".fancybox-wrap").swipe
        swipeLeft: (event, direction, distance, duration, fingerCount) ->
          $.fancybox.next()
        swipeRight: (event, direction, distance, duration, fingerCount) ->
          $.fancybox.prev()
        threshold: 50


  $(".message a>img").each (index, image) ->
    parent = $(this).closest("a")

    parent.attr("href", image.src)
    info = parent.closest(".mediaWrapper").find(".mediaText")
    parent.attr("caption", $(info).text())

    parent.fancybox
      helpers:
        title:
          type: "outside"

        thumbs:
          width: 50
          height: 50

      beforeLoad: ->
        @title = $(@element).attr("caption")
