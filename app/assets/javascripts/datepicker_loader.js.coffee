$(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
  $(this).datepicker
    format: "yyyy-mm-dd"
    weekStart: 1
    autoclose: true