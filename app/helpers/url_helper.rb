def UrlHelper
  # http://stackoverflow.com/a/1674372/871495
  # encodeURIComponent
  # # http://stackoverflow.com/a/25142319/871495
  def parameterize(params)
    URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
  end
end
