# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#messages_data_table").dataTable
    sDom: "<'row'<'col-md-6'l><'col-md-6 filterDiv'f>r>t<'row-fluid'<'col-md-6'i><'col-md-6'p>>"
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true #shows the processing bar
    bServerSide: true #für Ajax
    bRetrieve: true
    aaSorting: [[ 1, "asc" ]]
    aoColumnDefs: [
    #   sClass: "status"
    #   aTargets: [7]
    # ,
    #   asSorting: [ "asc" ]
    #   aTargets: [1]
    # ,
      bSortable: false
      aTargets: [0, 2, 4, 5, 6]
    ]
    iDisplayLength: 100
    aLengthMenu: [[10, 25, 50, 100, 100000], [10, 25, 50, 100, 100000]]
    sAjaxSource: $("#messages_data_table").data("source")
