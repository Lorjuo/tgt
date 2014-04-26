# $ ->
#   # $('.equal>div').equalHeights()
#   $(".equal>div").equalHeightColumns
#     minWidth: 750
#     # maxWidth: 1000
# http://stackoverflow.com/questions/18852342/group-elements-by-rel-attribute/18852602#18852602
$ ->
  $("#karneval").hover(
    -> $(".outer-slideshow").cycle('goto', 1),
    -> $(".outer-slideshow").cycle('goto', 0)
  )