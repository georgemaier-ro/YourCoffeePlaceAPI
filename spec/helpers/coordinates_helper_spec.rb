require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoordinatesHelper. For example:
#
# describe CoordinatesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoordinatesHelper, type: :helper do
  let!(:valid_float) { '34.3432' }
  let!(:invalid_float) { '-100.2%67' }
  let!(:latitude) { '34.3432' }
  let!(:longitude) { '-100.2567' }
  let!(:latitude_second) { '47.6' }
  let!(:longitude_second) { '-122.4' }
  let!(:float_latitude) { 34.3432 }
  let!(:float_longitude) { -100.2567 }
  let!(:float_latitude_second) { 47.6 }
  let!(:float_longitude_second) { -122.4 }

  describe 'check_if_valid_float' do
    context 'when valid float' do
      it 'returns true' do
        expect(check_if_valid_float(valid_float)).to be true
      end
    end

    context 'when invalid float' do
      it 'returns false' do
        expect(check_if_valid_float(invalid_float)).to be false
      end
    end
  end

  describe 'calculate_distance' do
    context 'when valid coordinates' do
      it 'returns the distance between the two vectors if values are string' do
        expect(calculate_distance(latitude, longitude, latitude_second, longitude_second)).to eq("25.8083")
      end

      it 'returns the distance between the two vectors if values are float' do
        expect(calculate_distance(float_latitude, float_longitude, float_latitude_second, float_longitude_second)).to eq("25.8083")
      end

      it 'returns the distance between the two vectors if some values are float' do
        expect(calculate_distance(latitude, longitude, float_latitude_second, float_longitude_second)).to eq("25.8083")
      end
    end

    context 'when invalid coordinates' do
      it 'raise an error' do
        expect { calculate_distance("$$%%", longitude, float_latitude_second, float_longitude_second) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid user coordinate $$%%, can't calculate distance."))
      end
    end
  end
end
