$ ->
  $(".select-all").click (event) ->
    event.preventDefault()
    $(this).closest("form").find("input:checkbox").prop "checked", true
