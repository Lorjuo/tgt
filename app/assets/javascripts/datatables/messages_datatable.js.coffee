$ ->
  tableContainer = $("#messages_data_table")
  tableContainer.dataTable $.extend({}, datatablesDefaults, datatablesPageable, datatablesResponsive,

    bServerSide: true #für Ajax
    #aaSorting: [[ 4, "desc" ]]
    order: [[ 4, "desc" ]]
    iDisplayLength: 5
    aLengthMenu: [[5, 10, 25, 100000], [5, 10, 25, 'all']]
    sAjaxSource: $("#messages_data_table").data("source")
  )


  # Filter term
  element_search_term = "#message_search_term"
  $(element_search_term).bind "input", ->
    filter_text( tableContainer, element_search_term, 2 )
  filter_text( tableContainer, element_search_term, 2 ) # also do this on load

  # Filter department
  element_department = "#message_department"
  $(element_department).change ->
    filter_select( tableContainer, element_department, 3 )
  filter_select( tableContainer, element_department, 3 ) # also do this on load

  # Message toggle published
  # http://stackoverflow.com/questions/24221367/like-button-ajax-in-ruby-on-rails
  # Alternatives:
  # http://www.topdan.com/ruby-on-rails/ajax-toggle-buttons.html
  # http://stackoverflow.com/questions/14154298/toggle-buttons-without-refreshing-using-ajax
  # https://www.railstutorial.org/book/following_users
  # TODO:
  # Restrict this part to only message pages / maybe already handled by 'a.publish'
  # $(document).on 'ajax:success', 'a.publish', (status,data,xhr)->

  #   # toggle links
  #   #$("a.publish[data-id=#{data.id}]").each ->
  #     #$a = $(this)

  #   $a = $("a.publish[data-id=#{data.id}]").last() # Only use last element, because turbolinks keeps some elements in cache
  #   href = $a.attr 'href'
  #   text = $a.html()
  #   $a.html(JSON.parse($a.data('toggle-text'))).attr 'href', $a.data('toggle-href')
  #   $a.data('toggle-text', JSON.stringify(text)).data 'toggle-href', href

  #   # Maybe use this for i18n:
  #   # http://blog.10to1.be/rails/2011/03/22/localizing-javascript-in-your-rails-app/
  #   # TODO: add publication marker in here - needs to get internationalized
  #   if (href.indexOf("true") >= 0)
  #     bootstrap_alert.success "Message has successfully been published"
  #   else
  #     bootstrap_alert.success "Message has successfully been withdrawn"