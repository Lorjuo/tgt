
var ww;

$(document).ready(function() {
  ww = document.body.clientWidth;

  $(".navigation li a").each(function() {
    if ($(this).next().length > 0) {
      $(this).addClass("parent");
      $(this).append( "<span class='indicator'></span>" )
      /*
        TODO use after insted of append
        ttp://api.jquery.com/after/
      */
    };
  })
  
  $(".toggleMenu").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("active");
    $(".navigation").toggle();
  });
  adjustMenu();
})

$(window).bind('resize orientationchange', function() {
  ww = document.body.clientWidth;
  adjustMenu();
});

var adjustMenu = function() {
  if (ww < 768) {
    $(".toggleMenu").css("display", "inline-block");
    if (!$(".toggleMenu").hasClass("active")) {
      $(".navigation").hide();
    } else {
      $(".navigation").show();
    }
    $(".navigation li").unbind('mouseenter mouseleave');
    $(".navigation li a.parent").unbind('click').bind('click', function(e) {
      // must be attached to anchor element to prevent bubbling
      e.preventDefault();
      $(this).parent("li").toggleClass("active");
    });
  } 
  else if (ww >= 768) {
    $(".toggleMenu").css("display", "none");
    $(".navigation").show();
    $(".navigation li").removeClass("active");
    $(".navigation li a").unbind('click');
    $(".navigation li").unbind('mouseenter mouseleave').bind('mouseenter mouseleave', function() {
      // must be attached to li so that mouseleave is not triggered when hover over submenu
      $(this).toggleClass('active');
    });
  }
}

