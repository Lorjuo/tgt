# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#messages_data_table").dataTable
    sDom: "<'row'<'col-md-6'l><'col-md-6 filterDiv'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: false
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
    iDisplayLength: 5
    aLengthMenu: [[5, 10, 25, 100000], [5, 10, 25, 'all']]
    sAjaxSource: $("#messages_data_table").data("source")
