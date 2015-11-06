# May be no longer needed, because of gem 'jquery-turbolinks'

# $(document).bind 'page:change', ->
#   Holder.run()

# Animation
# http://stackoverflow.com/questions/13009788/animate-pagechange-with-turbolinks
# http://carlosbecker.com/posts/animating-page-transitions-in-turbolinks/
# https://coderwall.com/p/t5ghhw
# $(document).on 'page:fetch', ->
#   $('.pageContent').fadeOut 'slow'

# $(document).on 'page:restore', ->
#   $('.pageContent').fadeIn 'slow'

$(document).on 'page:fetch', ->
  $('.loader').addClass('animate')#.show()
$(document).on 'page:change', ->
  $('.loader').removeClass('animate')#.hide()
# http://www.techdarkside.com/how-to-use-a-spinner-with-turbolinks