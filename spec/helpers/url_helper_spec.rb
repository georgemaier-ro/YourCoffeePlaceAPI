require 'rails_helper'

RSpec.describe UrlHelper, type: :helper do
  let! (:url) { "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }
  let! (:invalid_url) { "h!!!ttps://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }

  context 'read_remote_url' do
    it 'creates a URL page' do
      url_page = read_remote_url(url)
      expect(url_page.present?).to be true
    end

    it 'raise and error if url is invalid' do
      expect(url_page = read_remote_url(invalid_url)).to eq(api_error(1))
    end
  end
end
