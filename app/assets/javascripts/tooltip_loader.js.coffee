# $ ->
#   $("[data-toggle=\"tooltip\"]").tooltip placement: "top"

init_tooltips = () ->
  $("[data-toggle=\"tooltip\"]").tooltip
    placement: "auto right"
    container: 'body'

# Export this function to global scope
window.init_tooltips = init_tooltips

$ ->
  init_tooltips()
