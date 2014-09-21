$ ->
  # Maybe use this for i18n:
  # http://blog.10to1.be/rails/2011/03/22/localizing-javascript-in-your-rails-app/
  window.bootstrap_alert = -> #Create class / namespace

  # http://stackoverflow.com/questions/10082330/dynamically-create-bootstrap-alerts-box-through-javascript
  # http://www.queryadmin.com/997/automatically-close-twitter-bootstrap-alert-message/
  bootstrap_alert.success = (message) -> # Assign method to class
    #window.setTimeout (->
      html = "<div class=\"alert alert-success alert-dismissible\"><a class=\"close\" data-dismiss=\"alert\">×</a><span>" + message + "</span></div>"
      $(html).hide().appendTo("#alert-placeholder").fadeIn(1000).delay(2000).fadeOut 1000, ->
        $(this).remove()