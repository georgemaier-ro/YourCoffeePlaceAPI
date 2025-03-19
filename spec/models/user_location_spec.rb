require 'rails_helper'

RSpec.describe UserLocation, type: :model do
  context 'when user lat and lng values are valid' do
    it 'creates a UserLocation' do
      expect(UserLocation.new("-33.871843", "151.206767").valid?).to eq(true)
    end
  end

  context 'when user lat and lng values are invalid' do
    it 'does not create a UserLocation' do
      expect(UserLocation.new("-33.871%43", "151.206767").valid?).to eq(false)
    end
  end
end
