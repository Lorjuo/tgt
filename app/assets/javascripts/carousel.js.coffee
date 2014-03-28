jQuery ->
  $(".carousel").carousel interval: 7000 # in milliseconds
  $(".carousel").find(".item:nth-of-type(1)").addClass('active')