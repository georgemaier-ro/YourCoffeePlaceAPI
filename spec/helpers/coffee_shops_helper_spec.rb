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

    it 'raise an error if csv is invalid' do
      # expect(csv_table = create_csv_table_from_page(invalid_url)).to eq(api_error(3))
    end
  end
end
