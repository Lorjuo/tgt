class ShortRoute < ActiveRecord::Base
  validates :name, :url, :http_status, :presence => true
  validates :name, :uniqueness => true

  def get_url
    if self.url.start_with?('/', '#')
      self.url
    else
      url_with_protocol(self.url)
    end
  end
end
