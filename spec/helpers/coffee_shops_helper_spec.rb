require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoffeeShopsHelper. For example:
#
# describe CoffeeShopsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoffeeShopsHelper, type: :helper do
  let!(:latitude) { '34.3432' }
  let!(:longitude) { '-100.2567' }
  let!(:latitude_second) { '47.6' }
  let!(:longitude_second) { '-122.4' }
  let!(:latitude_third) { '22.56' }
  let!(:longitude_third) { '-120.567' }

  describe 'sort_coffee_shops_by_distance' do
    context 'when valid lat and lng' do
      it 'returns sorted locations' do
        sorted_table = sort_coffee_shops_by_distance(latitude, longitude)
        expect(sorted_table.present?).to be true
      end

      it 'returns required locations with lat=47.6 and lng=-122.4' do
        sorted_table = sort_coffee_shops_by_distance(latitude_second, longitude_second)
        expect(sorted_table.present?).to be true
        expect(sorted_table).to eq([ [ "Starbucks Seattle2", "0.0645", "47.5869", "-122.3368" ], [ "Starbucks Seattle", "0.0861", "47.5809", "-122.3160" ], [ "Starbucks SF", "10.0793", "37.5209", "-122.3340" ] ])
      end

      it 'returns required locations with lat=22.56 and lng=-120.567' do
        sorted_table = sort_coffee_shops_by_distance(latitude_third, longitude_third)
        expect(sorted_table.present?).to be true
        expect(sorted_table).to eq([ [ "Starbucks SF", "15.0649", "37.5209", "-122.3340" ], [ "Starbucks Seattle", "25.082", "47.5809", "-122.3160" ], [ "Starbucks Seattle2", "25.0894", "47.5869", "-122.3368" ] ])
      end
    end

    context 'when invalid lat or lng' do
      it 'raise an error if lat or lng are invalid' do
        expect(sorted_table = sort_coffee_shops_by_distance('#$', longitude_second)).to eq(api_error(4))
      end

      it 'raise an error if lat or lng are missing' do
        expect(sorted_table = sort_coffee_shops_by_distance('', longitude_second)).to eq(api_error(4))
      end
    end
  end
end
