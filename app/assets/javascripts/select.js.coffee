$ ->
  $(".select-all").click (event) ->
    event.preventDefault()

    value = $(this).attr('data-selected')
    selected = (typeof value isnt "undefined") && (value is 'true')

    # http://stackoverflow.com/questions/14482492/how-to-toggle-data-attribute-with-jquery
    $(this).closest("form").find("input:checkbox").prop "checked", !selected

    $(this).attr "data-selected", (if selected then 'false' else 'true')

  $(".checkboxWrapper").click ->
    checkbox = $(this).find("input:checkbox")
    checkbox.prop "checked", !checkbox.prop("checked")

  $(".checkboxWrapper input:checkbox").click (event) ->
    event.stopPropagation()