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
