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
        height: 50

    beforeLoad: ->
      @title = $(@element).attr("caption")


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
