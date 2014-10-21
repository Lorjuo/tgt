# $ ->
#   # $('.equal>div').equalHeights()
#   $(".equal>div").equalHeightColumns
#     minWidth: 750
#     # maxWidth: 1000
# http://stackoverflow.com/questions/18852342/group-elements-by-rel-attribute/18852602#18852602
$ ->
  $("#verein").hover(
    -> $(".outer-slideshow").cycle('goto', 0)#,
    #-> $(".outer-slideshow").cycle('goto', 0)
  )
  $("#sport").hover(
    -> $(".outer-slideshow").cycle('goto', 1)#,
    #-> $(".outer-slideshow").cycle('goto', 0)
  )
  $("#karneval").hover(
    -> $(".outer-slideshow").cycle('goto', 2)#,
    #-> $(".outer-slideshow").cycle('goto', 0)
  )
  $("#ohlebach").hover(
    -> $(".outer-slideshow").cycle('goto', 3)#,
    #-> $(".outer-slideshow").cycle('goto', 0)
  )
  # $(".homeCycle .tabs").mouseleave(
  #   -> $(".outer-slideshow").cycle('goto', 0)
  # )