# TODO: Bilder müssen bereits geladen sein
# in chrome nicht gegeben
# jQuery ->
$(window).load ->
  # TODO: specify .pagination only on endless pages
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page a').attr('href')
      #if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50 # Bottum Spacing - default: 50
      if url && $(window).scrollTop() > $("body").height() - $(window).height() - 50
        # Translate this message
        $('.pagination').text("Fetching more items...")
        $.getScript(url)
    $(window).scroll()