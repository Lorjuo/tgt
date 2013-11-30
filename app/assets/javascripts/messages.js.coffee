$ ->
  $("#messages_data_table").dataTable $.extend(datatablesDefaults, datatablesSearchable, datatablesResponsive,

    bServerSide: true #für Ajax
    aaSorting: [[ 1, "asc" ]]
    iDisplayLength: 5
    aLengthMenu: [[5, 10, 25, 100000], [5, 10, 25, 'all']]
    sAjaxSource: $("#messages_data_table").data("source")
  )
