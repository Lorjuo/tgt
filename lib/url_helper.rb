module UrlHelper
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  # Maybe use "included do" # http://stackoverflow.com/questions/16720514/how-to-use-url-helpers-in-lib-modules-and-set-host-for-multiple-environments
  # included do
  #   def default_url_options
  #     ActionMailer::Base.default_url_options
  #   end
  # end
end