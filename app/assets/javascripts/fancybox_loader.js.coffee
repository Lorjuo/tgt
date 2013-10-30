$(document).ready ->
  $(".fancybox").fancybox
    helpers:
      title:
        type: "outside"

      thumbs:
        width: 50
        height: 50

    beforeLoad: ->
      @title = $(@element).attr("caption")
