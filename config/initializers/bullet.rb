if defined? Bullet # Or move this block to development.rb and add it to a config.after_initialize block
  Bullet.enable = false
  Bullet.alert = false
  # Bullet.bullet_logger = true
  # Bullet.console = true
  # Bullet.growl = true
  # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
  #                 :password => 'bullets_password_for_jabber',
  #                 :receiver => 'your_account@jabber.org',
  #                 :show_online_status => true }
  # Bullet.rails_logger = true
  # Bullet.airbrake = true
  # Bullet.add_footer = true
  # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
end