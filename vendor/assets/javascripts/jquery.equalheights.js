/*
* Simple jQuery Equal Heights
*
* Copyright (c) 2012 Matt Banks
* Dual licensed under the MIT and GPL licenses.
* Uses the same license as jQuery, see:
* http://docs.jquery.com/License
*
* @version 1.3
*/
// (function($) {

//   $.fn.equalHeights = function() {
//     var maxHeight = 0,
//                 $this = $(this);

//     $this.each( function() {
//       var height = $(this).innerHeight();

//       if ( height > maxHeight ) { maxHeight = height; }
//     });

//     return $this.height(maxHeight);
//   };

// })(jQuery);

/*global jQuery */
/*!
* equalHeightColumns.js 1.1
*
* Copyright 2013, Paul Sprangers http://paulsprangers.com
* Released under the WTFPL license
* http://www.wtfpl.net
*
* Date: Thu Aug 8 12:18:00 2013 +0100
*/

(function( $ ){

    $.fn.equalHeightColumns = function( options ) {

            defaults = {
                minWidth: -1, // Won't resize unless window is wider than this value
                maxWidth: 99999, // Won't resize unless window is narrower than this value
                setHeightOn: 'min-height' // The CSS attribute on which the equal height is set. Usually height or min-height
            };

            var $this = $(this); // store the object
            options = $.extend( {}, defaults, options ); // merge options
            
            // Recalculate the distance to the top of the element to keep it centered
            var resizeHeight = function () {

                // Get window width
                var windowWidth = $(window).width();

                // Check to see if the current browser width falls within the set minWidth and maxWidth
                if( options.minWidth < windowWidth && options.maxWidth > windowWidth ){
                    var height = 0;
                    var highest = 0;

                    // Reset heights
                    $this.css( options.setHeightOn, 0 );

                    // Figure out the highest element
                    $this.each( function(){

                        height = $(this).height();

                        if( height > highest ){
                            highest = height;
                        }

                    } );

                    // Set that height on the element
                    $this.css( options.setHeightOn, highest );
                    bla = test;

                }
                else{
                    // Add check so this doesn't have to happen everytime
                    $this.css( options.setHeightOn, 0 );
                }
            };

            // Call once to set initially
            resizeHeight();

            // Call on resize. Opera debounces their resize by default.
            $(window).resize(resizeHeight);
            
            // Also check if any images are present and recalculate when they load
            // there might be an optimization opportunity here
            $this.find('img').load( resizeHeight );
            
            // If afterLoading is defined, add a load event to the selector
            if ( typeof options.afterLoading !== 'undefined' ) {
                    $this.find(options.afterLoading).load( resizeHeight );
                        }
                        
                        // If afterTimeout is defined use it a the timeout value
                        if ( typeof options.afterTimeout !== 'undefined' ) {
                    setTimeout(function(){
                 resizeHeight();
                 
                 // check afterLoading again, to make sure that dynamically added nodes are present
                 if ( typeof options.afterLoading !== 'undefined' ) {
                         $this.find(options.afterLoading).load( resizeHeight );
                                        }
                    }, options.afterTimeout);
                        }

    };

})( jQuery );

//see: https://github.com/PaulSpr/jQuery-Equal-Height-Columns/blob/master/jquery.equalheightcolumns.js
//see: http://stackoverflow.com/questions/13029090/jquery-equal-height-responsive-div-rows

$.fn.extend({
    equalHeights: function(){
        var top=0;
        var row=[];
        var classname=('equalHeights'+Math.random()).replace('.','');
        $(this).each(function(){
            var thistop=$(this).offset().top;
            if (thistop>top) {
                $('.'+classname).removeClass(classname); 
                top=thistop;
            }
            $(this).addClass(classname);
            $(this).height('auto');
            var h=(Math.max.apply(null, $('.'+classname).map(function(){ return $(this).outerHeight(); }).get()));
            $('.'+classname).height(h);
        }).removeClass(classname); 
    }      
});

$(function(){
  $(window).resize(function(){
    $('.eqme>div').equalHeights();
  }).trigger('resize');
});
