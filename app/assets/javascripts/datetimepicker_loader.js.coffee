init_pickers = ->
  $(".datepicker").datetimepicker pickTime: false
  $(".datetimepicker").datetimepicker pickSeconds: false
  $(".timepicker").datetimepicker
    pickDate: false
    pickSeconds: false

# Export this function to global scope
window.init_pickers = init_pickers

$ ->
  init_pickers()
