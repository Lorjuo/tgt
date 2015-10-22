#http://stackoverflow.com/questions/2274627/how-can-i-get-horizontal-scrollbars-at-top-and-bottom-of-a-div
# doubleScroll = (element) ->
#   scrollbar = $(document.createElement('div'))
#   scrollbar.append(document.createElement('div'))
#   scrollbar.css('overflow', 'auto')
#   scrollbar.css('overflowY', 'hidden')
#   scrollbar.children(":first").css('width', element.get(0).scrollWidth + 'px')
#   scrollbar.children(":first").css('paddingTop', '1px')
#   scrollbar.children(":first").append(document.createTextNode(' '))

#   scrollbar.get(0).onscroll = ->
#     element.get(0).scrollLeft = scrollbar.get(0).scrollLeft
#     return

#   element.get(0).onscroll = ->
#     scrollbar.get(0).scrollLeft = element.get(0).scrollLeft
#     return

#   #element.insertBefore scrollbar
#   scrollbar.insertBefore element

$ ->
  $(".event").popover
    trigger: "hover"
    container: "body"

  #doubleScroll $(".doubleScroll")

  $('.doubleScroll').each ->
    element = $(this)
    scrollbar = $(document.createElement('div'))
    scrollbar.append(document.createElement('div'))
    scrollbar.css('overflow', 'auto')
    scrollbar.css('overflowY', 'hidden')
    scrollbar.children(":first").css('width', element.get(0).scrollWidth + 'px')
    scrollbar.children(":first").css('paddingTop', '1px')
    scrollbar.children(":first").append(document.createTextNode(' '))

    scrollbar.get(0).onscroll = ->
      element.get(0).scrollLeft = scrollbar.get(0).scrollLeft
      return

    element.get(0).onscroll = ->
      scrollbar.get(0).scrollLeft = element.get(0).scrollLeft
      return

    #element.insertBefore scrollbar
    scrollbar.insertBefore element