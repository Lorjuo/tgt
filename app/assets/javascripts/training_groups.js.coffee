$ ->
  # Init Datatable
  tableContainer = $("#training_groups_data_table")
  tableContainer.dataTable $.extend({}, datatablesDefaults, datatablesPageable, datatablesResponsive,

    bServerSide: true #für Ajax
    aaSorting: [[ 1, "asc" ]]
    sAjaxSource: $("#training_groups_data_table").data("source")
  )


  # Filter age
  element_week_days = "#training_group_week_days"
  $(element_week_days).change ->
    filter_select( tableContainer, element_week_days, 2 )
  filter_select( tableContainer, element_week_days, 2 ) # also do this on load

  # Filter age
  element_age = "#training_group_age"
  $(element_age).bind "input", ->
    filter_text( tableContainer, element_age, 3 )
  filter_text( tableContainer, element_age, 3 ) # also do this on load

  # Filter age
  element_departments = "#training_group_departments"
  $(element_departments).change ->
    filter_select( tableContainer, element_departments, 4 )
  filter_select( tableContainer, element_departments, 4 ) # also do this on load

  # Filter keywords
  element_keywords = "#training_group_keywords"
  $(element_keywords).bind "input", ->
    filter_text( tableContainer, element_keywords, 5 )
  filter_text( tableContainer, element_keywords, 5 ) # also do this on load

  $("a.add_fields")
    .data("association-insertion-position", "append")
    .data "association-insertion-node", "#insertionNode"
