# Methods for handling external URLs

module UrlHelper
  include ErrorsHelper

  def read_remote_url(url)
    begin
      url_page = URI.open(url)
    rescue StandardError
      api_error 1
    else
      url_page
    end
  end
end
