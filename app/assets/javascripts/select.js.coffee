$ ->
  $(".select-all").click (event) ->
    event.preventDefault()
    $(this).closest("form").find("input:checkbox").prop "checked", true

  $(".checkboxWrapper").click ->
    checkbox = $(this).find("input:checkbox")
    checkbox.prop "checked", !checkbox.prop("checked")

  $(".checkboxWrapper input:checkbox").click (event) ->
    event.stopPropagation()