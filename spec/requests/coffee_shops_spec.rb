require 'rails_helper'

RSpec.describe "CoffeeShops", type: :request do
  let!(:latitude) { '34.3432' }
  let!(:longitude) { '-100.2567' }
  let!(:latitude_second) { '47.6' }
  let!(:longitude_second) { '-122.4' }

  describe "GET /get_coffee" do
    context 'with valid lat and long' do
      it 'returns the sorted top 3 coffee shops' do
        get '/coffee_shops/:get_coffee', params: { latitude: latitude_second, longitude: longitude_second }
        expect(JSON.parse(response.body)).to eq([["Starbucks Seattle2", "0.0645", "47.5869", "-122.3368"], ["Starbucks Seattle", "0.0861", "47.5809", "-122.3160"], ["Starbucks SF", "10.0793", "37.5209", "-122.3340"]])
      end
    end
  end
end
