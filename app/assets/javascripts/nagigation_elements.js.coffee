# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#navigation_element_controller_id").change ->
    controller = $("#navigation_element_controller_id").val()
    if controller
      $.ajax
        url: "/navigation_elements/updated_controller"
        data:
          controller_id: $("#navigation_element_controller_id").val()
        dataType: "script"
  $("#navigation_element_controller_id").trigger "change"
