# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#media_link_controller_id, #functional_page_controller_id").change ->
    controller = $(this).val()
    link_type = controller.replace('_controller_id','s');
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
