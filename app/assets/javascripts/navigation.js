/* BOOTSTRAP NAVIGATION BAR */

$(function() {
  return $('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
    event.preventDefault();
    event.stopPropagation();
    $(this).parent().siblings().removeClass('open');
    return $(this).parent().toggleClass('open');
  });
  /*.on('mouseover', function(event) {
    //event.preventDefault();
    //event.stopPropagation();
    //$(this).parent().siblings().removeClass('open');
    //return $(this).parent().addClass('open');
    
  });*/
});

/* CUSTOM NAVIGATION BAR */

/* http://andylangton.co.uk/blog/development/get-viewport-size-width-and-height-javascript */
function viewport() {
  var e = window, a = 'inner';
  if (!('innerWidth' in window )) {
    a = 'client';
    e = document.documentElement || document.body;
  }
  return { width : e[ a+'Width' ] , height : e[ a+'Height' ] };
}


var ww;

$(document).ready(function() {
  ww = viewport().width;

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
  
  $(".navigation-bar-toggle").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("active");
    $(".navigation-collapse").slideToggle();
  });
  adjustMenu();
})

$(window).bind('resize orientationchange', function() {
  ww = viewport().width;
  adjustMenu();
});

var adjustMenu = function() {
  if (ww < 768) {
    $(".navigation-collapse").removeClass( "desktop" ).addClass( "mobile" )
    $(".navigation-bar-toggle").css("display", "inline-block");
    if (!$(".navigation-bar-toggle").hasClass("active")) {
      $(".navigation-collapse").hide();
    } else {
      $(".navigation-collapse").show();
    }
    $(".navigation li").unbind('mouseenter mouseleave');
    $(".navigation li a.parent").unbind('click').bind('click', function(e) {
      // must be attached to anchor element to prevent bubbling
      e.preventDefault();
      $(this).parent("li").toggleClass("active");
    });
  } 
  else if (ww >= 768) {
    $(".navigation-collapse").removeClass( "mobile" ).addClass( "desktop" )
    $(".navigation-bar-toggle").css("display", "none");
    $(".navigation-collapse").show();
    $(".navigation li").removeClass("active");
    $(".navigation li a").unbind('click');
    $(".navigation li").unbind('mouseenter mouseleave').bind('mouseenter mouseleave', function() {
      // must be attached to li so that mouseleave is not triggered when hover over submenu
      $(this).toggleClass('active');
    });
  }
}

