$ ->
  tableContainer = $("#messages_data_table")
  tableContainer.dataTable $.extend({}, datatablesDefaults, datatablesSearchable, datatablesResponsive,

    bServerSide: true #für Ajax
    aaSorting: [[ 1, "asc" ]]
    iDisplayLength: 5
    aLengthMenu: [[5, 10, 25, 100000], [5, 10, 25, 'all']]
    sAjaxSource: $("#messages_data_table").data("source")
  )


  # Filter term
  element_search_term = "#message_search_term"
  $(element_search_term).bind "input", ->
    filter_text( tableContainer, element_search_term, 2 )
  filter_text( tableContainer, element_search_term, 2 ) # also do this on load

  # Filter age
  element_department = "#message_department"
  $(element_department).change ->
    filter_select( tableContainer, element_department, 3 )
  filter_select( tableContainer, element_department, 3 ) # also do this on load
