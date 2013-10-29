# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#navigation_element_controller_id").change ->
    controller = $("#navigation_element_controller_id").val()
    # if controller
    #   $.ajax
    #     # TODO: Maybe append department id
    #     type: "GET",
    #     url: "/navigation_elements/updated_controller"
    #     data:
    #       controller_id: $("#navigation_element_controller_id").val()
    #     dataType: "script"
# $("#navigation_element_controller_id").trigger "change"
    $.ajax
      # TODO: Maybe append department id
      type: "GET",
      url: "/navigation_elements/change_controller"
      data:
        navigation_element:
          controller_id: $("#navigation_element_controller_id").val()
      dataType: "html"
      success: (content) ->
        $("#controllerDependentForm").html content
      error: (xhr, ajaxOptions, thrownError) ->
        alert xhr.status
        alert thrownError
