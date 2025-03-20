require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoffeeShopValidatorHelper. For example:
#
# describe CoffeeShopValidatorHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoffeeShopValidator, type: :helper do
  let!(:coffee_shops) { [ [ "Starbucks Seattle2", "47.5869", "-122.3368" ], [ "Starbucks Seattle", "47.5809", "-122.3160" ], [ "Starbucks SF", "37.5209", "-122.3340" ] ] }
  let!(:bad_coffee_shops) { [ [ "47.5869", "-122.3368" ], [ "Starbucks Seattle", "47.5809", "-122.3160" ], [ "Starbucks SF", "10.0793", "37.5209", "-122.3340" ] ] }
  let!(:coffee_shop) { [ "Starbucks Seattle2", "47.5869", "-122.3368" ] }
  let!(:bad_coffee_shop) { [ "47.5869", "-122.3368" ] }
  let!(:missing_lat_coffee_shop) { [ "Starbucks Seattle2", "", "-122.3368" ] }
  let!(:invalid_lat_coffee_shop) { [ "Starbucks Seattle2", "47.5%869", "-122.3368" ] }

  describe 'validate_coffee_shop_locations' do
    context 'when provided with a valid array of coffee shops' do
      it 'creates a list of all valid coffee shops' do
        valid_array_of_locations = validate_coffee_shop_locations(coffee_shops)
        expect(valid_array_of_locations).to eq([ [ "Starbucks Seattle2", "47.5869", "-122.3368" ], [ "Starbucks Seattle", "47.5809", "-122.3160" ], [ "Starbucks SF", "37.5209", "-122.3340" ] ])
      end
    end

    context 'when provided with an array of coffee shops with some bad ones' do
      it 'it only adds the valid coffee shops' do
        valid_array_of_locations = validate_coffee_shop_locations(bad_coffee_shops)
        expect(valid_array_of_locations).to eq([ [ "Starbucks Seattle", "47.5809", "-122.3160" ], [ "Starbucks SF", "10.0793", "37.5209", "-122.3340" ] ])
      end
    end
  end

  describe 'validate_coffee_shop' do
    context 'when provided with a valid coffee shop' do
      it 'it returns true' do
        expect(validate_coffee_shop(coffee_shop)).to eq(true)
      end
    end

    context 'when provided with a bad coffee shop with missing name' do
      it 'it returns false' do
        expect(validate_coffee_shop(bad_coffee_shop)).to eq(false)
      end
    end

    context 'when provided with a bad coffee shop with missing lat' do
      it 'it returns false' do
        expect(validate_coffee_shop(missing_lat_coffee_shop)).to eq(false)
      end
    end

    context 'when provided with a bad coffee shop with invalid lat' do
      it 'it returns false' do
        expect(validate_coffee_shop(invalid_lat_coffee_shop)).to eq(false)
      end
    end
  end
end
