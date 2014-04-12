# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#navigation_element_controller_id").change ->
    controller = $(this).val()
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
      type: "GET",
      url: "/departments/"+department_id+"/navigation_elements/change_controller"
      data:
        navigation_element:
          controller_id: controller      
      dataType: "html"
      success: (content) ->
        $("#controllerDependentForm").html content
      error: (xhr, ajaxOptions, thrownError) ->
        alert xhr.status
        alert thrownError


  $("#media_link_controller_id").change ->
    controller = $(this).val()
    $.ajax
      type: "GET",
      url: "/departments/"+department_id+"/media_links/change_controller"
      data:
        media_link:
          controller_id: controller         
      dataType: "html"
      success: (content) ->
        $("#controllerDependentForm").html content
      error: (xhr, ajaxOptions, thrownError) ->
        alert xhr.status
        alert thrownError
