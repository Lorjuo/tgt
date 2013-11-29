# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $ ->
#   $("#training_groups_data_table").dataTable
#     sDom: "<'row'<'col-md-6'l><'col-md-6 filterDiv'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>"
#     sPaginationType: "bootstrap"
#     bJQueryUI: false
#     bProcessing: true #shows the processing bar
#     bServerSide: true #für Ajax
#     bRetrieve: true
#     aaSorting: [[ 1, "asc" ]]
#     aoColumnDefs: [
#     #   sClass: "status"
#     #   aTargets: [7]
#     # ,
#     #   asSorting: [ "asc" ]
#     #   aTargets: [1]
#     # ,
#       bSortable: false
#       aTargets: [0, 2, 5]
#     ]
#     iDisplayLength: 5
#     aLengthMenu: [[5, 10, 25, 100000], [5, 10, 25, 'all']]
#     sAjaxSource: $("#training_groups_data_table").data("source")


filter_text = (tableContainer, element, colNum) ->
  if ($(tableContainer).length > 0)
    oTable = $(tableContainer).dataTable()
    oTable.fnFilter( $(element)[0].value, colNum )

filter_select = (tableContainer, element, colNum) ->
  if ($(tableContainer).length > 0)
    oTable = $(tableContainer).dataTable()

    selectedIds = new Array()
    $(element).children(":selected").each ->
      selectedIds.push(this.value)
    oTable.fnFilter( selectedIds.join(','), colNum )

# Export this function to global scope
window.filter_text = filter_text
window.filter_select = filter_select


$ ->
  responsiveHelper = undefined
  # https://github.com/thomas-mcdonald/bootstrap-sass/blob/master/vendor/assets/stylesheets/bootstrap/_variables.scss
  breakpointDefinition =
    #xxs: 480 # Smaller than ...
    xs: 768
    sm: 992
    md: 1200
    lg: 1900

  tableContainer = $("#training_groups_data_table")
  tableContainer.dataTable
    sDom: "<'row'<'col-md-6'l><'col-md-6 filterDiv'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>"

    sPaginationType: "bootstrap"
    # Setup for responsive datatables helper.
    bAutoWidth: false
    bStateSave: false

    fnPreDrawCallback: ->
      responsiveHelper = new ResponsiveDatatablesHelper(tableContainer, breakpointDefinition) unless responsiveHelper

    fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
      responsiveHelper.createExpandIcon nRow

    fnDrawCallback: (oSettings) ->
      responsiveHelper.respond()
      init_tooltips() # Notice: Maybe move this to rowcallback

    bServerSide: true #für Ajax
    aaSorting: [[ 1, "asc" ]]
    sAjaxSource: $("#training_groups_data_table").data("source")
    aoColumnDefs: [
    #   sClass: "status"
    #   aTargets: [7]
    # ,
    #   asSorting: [ "asc" ]
    #   aTargets: [1]
    # ,
      bSortable: false
      aTargets: ["image", "actions"]
    ]


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

  $('.datatable').dataTable
    sPaginationType: "bootstrap"
    #sDom: "<'row'<'col-md-6'l><'col-md-6 filterDiv'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>"
    #sDom: "<r>t<'row'<'col-md-6'i><'col-md-6'p>>"
    sDom: "<r>t<'row'>"
    iDisplayLength: 9999
    bProcessing: true
    bServerSide: false #für Ajax

  $("a.add_fields")
    .data("association-insertion-position", "append")
    .data "association-insertion-node", "#insertionNode"
