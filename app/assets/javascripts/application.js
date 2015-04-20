// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//
//# JQuery
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//# http://stackoverflow.com/questions/17053650/ruby-on-rails-couldnt-find-file-jquery-ui
//# require jquery.ui.all
//= require jquery_ujs
//
//= require holder
//
//# Bootstrap
//= require bootstrap-sprockets
//# Bootstrap Javascript
// require bootstrap/scrollspy
// require bootstrap/modal
//= require bootstrap/dropdown
//# Loaders
//= require tooltip_loader
//= require bootstrap_alert
//
//# Clipboard # TODO: Check if this is needed
//#ZeroClipBoardDisabled:
// require zeroclipboard
//
//# Colorpicker
//= require bootstrap-colorpicker
//= require colorpicker_loader
//
//# Forked Datetimepicker
//# require bootstrap-datetimepicker
//= require bootstrap-datetimepicker/core
//# require bootstrap-datetimepicker/pickers
//= require bootstrap-datetimepicker/locales/bootstrap-datetimepicker.de.js
//= require datetimepicker_loader
//
//# EqualHeights # TODO: Maybe remove this
//= require equal_heights_loader
//
//# Google Maps # TODO: Maybe remove this
//#Gmaps4RailsDisabled:
// require gmaps/google
// 
//# File Upload
//# require jquery-fileupload
//# require jquery-fileupload/basic
//
//# Fileupload needs to be in the right order
//# https://github.com/blueimp/jQuery-File-Upload/wiki/Client-side-Image-Resizing
//# http://stackoverflow.com/questions/19096946/how-to-resize-images-client-side-using-jquery-file-upload
//# require jquery-fileupload/vendor/jquery.ui.widget
//# require jquery-fileupload/vendor/load-image
//# require jquery-fileupload/vendor/canvas-to-blob
//# require jquery-fileupload/vendor/tmpl
//# require jquery-fileupload/jquery.iframe-transport
//# require jquery-fileupload/jquery.fileupload
//# require jquery-fileupload/jquery.fileupload-ui
//# require jquery-fileupload/jquery.fileupload-process
//# require jquery-fileupload/jquery.fileupload-validate
//# require jquery-fileupload/jquery.fileupload-image
//
//= require jquery-fileupload/vendor/jquery.ui.widget
//= require jquery-fileupload/vendor/tmpl
//= require jquery-fileupload/vendor/load-image.all.min
//= require jquery-fileupload/vendor/canvas-to-blob
//= require jquery-fileupload/jquery.iframe-transport
//= require jquery-fileupload/jquery.fileupload
//= require jquery-fileupload/jquery.fileupload-process
//= require jquery-fileupload/jquery.fileupload-image
//# require jquery-fileupload/jquery.fileupload-audio
//# require jquery-fileupload/jquery.fileupload-video
//= require jquery-fileupload/jquery.fileupload-validate
//= require jquery-fileupload/jquery.fileupload-ui
//= require jquery-fileupload/locale
//# require jquery-fileupload/jquery.fileupload-angular
//# require jquery-fileupload/jquery.fileupload-jquery-ui
//= require jquery-fileupload/cors/jquery.postmessage-transport
//= require jquery-fileupload/cors/jquery.xdr-transport
//
//= require fileupload
//
//= require jquery
// require jquery.jcrop
//
//# File Upload Button
//= require fileupload_button
//
//# Forms
//= require ajax_forms
// 
//# Input Elements
//# Chosen
//= require chosen-jquery
//= require chosen_loader
//= require jquery_popup_uploader
//
//# Images
//= require fancybox_loader
//= require fancybox
//= require jquery.mousewheel-3.0.6.pack
//= require preview_cycle
//= require cycle2_loader
//= require jquery.cycle2
// require jquery.cycle2.caption2.js
//# At the moment this is not needed because it does not work with turbolinks
//
//# Navigation
//= require navigation
//= require links
//
//# Nested Forms
//= require cocoon
//= require nested_forms_loader
//
//# Pagination
//= require endless_page
//
//# Seat Reservation
//= require seatReservation
//
//# Select
//= require select
//# Sortable Tree
//= require jquery.ui.nestedSortable
//= require sortable_tree/initializer
//
//# Table
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//# require dataTables/jquery.dataTables
//# require dataTables/jquery.dataTables.bootstrap3
//# require dataTables/jquery.dataTables.responsive
//= require datatables
//
//# Underscore js
//=require underscore
//# at the moment needed for jquery dataTables responsive and gmaps4rails
//
// require_tree .
// require_directory .
// 
//# Specific Pages
//= require home
//= require messages
//= require schedule
//= require training_groups
//
//# Swype
//= require jquery.touchSwipe.js
//
//# Grid # Has to be some of the last scripts to include, because especially chosen can change the page adjustments
//= require jquery.equalheights
//
//# Has to be the last (https://github.com/kossnocorp/jquery.turbolinks)
//= require turbolinks
//= require turbolink_fixes
//# TODO: Check if including administration-bundle.js after this line has negative effects

document.addEventListener("page:restore", function() {
    app.init();
});
//Turbolinks.pagesCached(0);
// http://stackoverflow.com/questions/17029399/clicking-back-in-the-browser-disables-my-javascript-code-if-im-using-turbolin