# http://stackoverflow.com/a/8234485/871495

ActionController::Responder.class_eval do
  alias :to_mobile :to_html
end