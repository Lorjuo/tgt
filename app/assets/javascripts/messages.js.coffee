# This should not be in "$->"-section because callbacks will be set every time a new page is loaded by turbolinks
$(document).on 'ajax:success', 'a.publish', (e, data, status, xhr) ->

  # Get button element
  button = $("a.publish[data-id=#{data.id}]").last() # Only use last element, because turbolinks keeps some elements in cache
  
  # get current button attributes
  href = button.attr 'href'
  text = button.html()

  # Check if message is published or unpublished:
  published = (href.indexOf("true") >= 0)

  # change button attributes
  button.html(JSON.parse(button.data('toggle-text'))).attr 'href', button.data('toggle-href')
  button.data('toggle-text', JSON.stringify(text)).data 'toggle-href', href

  # Maybe use this for i18n:
  # http://blog.10to1.be/rails/2011/03/22/localizing-javascript-in-your-rails-app/
  # TODO: add publication marker in here - needs to get internationalized
  if published
    bootstrap_alert.success "Message has successfully been published"
  else
    bootstrap_alert.success "Message has successfully been withdrawn"

  # change publication indicator
  message = button.closest('div.message')
  if published
    marker = message.find('i.publication-marker.published').css('display','inline')
    marker = message.find('i.publication-marker.unpublished').css('display','none')
  else
    marker = message.find('i.publication-marker.published').css('display','none')
    marker = message.find('i.publication-marker.unpublished').css('display','inline')