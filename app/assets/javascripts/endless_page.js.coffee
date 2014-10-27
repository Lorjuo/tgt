# TODO: Bilder müssen bereits geladen sein
# in chrome nicht gegeben
# jQuery ->
# # $(window).load ->
#   # TODO: specify .pagination only on endless pages
#   if $('.pagination').length
#     $(window).scroll ->
#       url = $('.pagination .next_page a').attr('href')
#       #if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50 # Bottum Spacing - default: 50
#       if url && $(window).scrollTop() > $("body").height() - $(window).height() - 50
#         # Translate this message
#         $('.pagination').text("Fetching more items...")
#         $.getScript(url)
#     $(window).scroll()

# Issues:
# At the moment there is no possibility to add images dynamically to fancybox when fancybox is open
# Possible approachs can be find here:
# https://github.com/fancyapps/fancyBox/issues/242
# https://github.com/fancyapps/fancyBox/issues/257
# And it will be probably possible to populate fancybox dynamically on fancybox version 3:
# http://fancyapps.com/fancybox/beta/

onEndless = ->
  $(window).off 'scroll', onEndless
  url = $('.pagination .next_page a').attr('href')
  $('.paginator').hide()
  if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
    #$('.loader').show()
    $('.pagination').text("Fetching more items...")
    $.getScript url, ->
      $(window).on 'scroll', onEndless # Set callback
      $(window).scroll() # Exectue immediately
      init_tooltips() # Reinit tooltips
  else
    $(window).on 'scroll', onEndless

$(window).on 'scroll', onEndless # Set callback
$(window).scroll() # Exectue immediately