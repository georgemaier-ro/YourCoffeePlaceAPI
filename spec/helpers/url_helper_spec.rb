require 'rails_helper'

RSpec.describe UrlHelper, type: :helper do
  let! (:url) { ENV['COFFEE_SHOP_URL'] }
  let! (:invalid_url) { "h!!!ttps://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }

  context 'read_remote_url' do
    it 'creates a URL page' do
      url_page = read_remote_url(url)
      expect(url_page.present?).to be true
    end

    it 'raise an error if url is invalid' do
      expect { read_remote_url(invalid_url) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "The URL provided is invalid."))
    end
  end
end
