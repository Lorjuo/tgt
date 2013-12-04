$ ->
  $(".select-all").click (event) ->
    event.preventDefault()
    $(this).closest("form").find("input:checkbox").prop "checked", true

  $(".checkbox-wrapper").click ->
    checkbox = $(this).find("input:checkbox")
    checkbox.prop "checked", !checkbox.prop("checked")

  $(".checkbox-wrapper input:checkbox").click (event) ->
    event.stopPropagation()