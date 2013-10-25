jQuery ->
  $(".carousel").carousel interval: 3000 # in milliseconds
  $(".carousel").find(".item:nth-of-type(1)").addClass('active')