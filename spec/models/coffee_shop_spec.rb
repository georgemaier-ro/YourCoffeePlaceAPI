require 'rails_helper'

RSpec.describe CoffeeShop, type: :model do
  let!(:coffee_shop) { CoffeeShop.new("Starbucks Sydney", "-33.871843", "151.206767") }

  context 'when user lat and lng values are valid' do
    it 'creates a CoffeeShop' do
      expect(CoffeeShop.new("Starbucks Sydney", "-33.871843", "151.206767").valid?).to eq(true)
    end
  end

  context 'when user lat and lng values are invalid' do
    it 'does not create a CoffeeShop' do
      expect(CoffeeShop.new("Starbucks Sydney", "-33.871%43", "151.206767").valid?).to eq(false)
    end
  end

  context 'when user lat and lng values are strings' do
    it 'correctly calculates distance.' do
      user_latitude = "-22.923489"
      user_longitude = "-43.234418"
      coffee_shop.get_distance_to_coffee_shop(user_latitude, user_longitude)
      expect(coffee_shop.distance.present?).to eq(true)
      expect(coffee_shop.distance).to eq("194.7492")
    end
  end

  context 'when user lat and lng values are floats' do
    it 'correctly calculates distance.' do
      user_latitude = -22.923489
      user_longitude = -43.234418
      coffee_shop.get_distance_to_coffee_shop(user_latitude, user_longitude)
      expect(coffee_shop.distance.present?).to eq(true)
      expect(coffee_shop.distance).to eq("194.7492")
    end
  end

  context 'when user lat and lng values are nil' do
    it 'raises an error' do
      user_latitude = nil
      user_longitude = nil
      expect { coffee_shop.get_distance_to_coffee_shop(user_latitude, user_longitude) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid user coordinate , can't calculate distance."))
    end
  end

  context 'when user lat and lng values are malformed' do
    it 'raises an error' do
      user_latitude = 'asdaewef'
      user_longitude = '$$###%'
      expect { coffee_shop.get_distance_to_coffee_shop(user_latitude, user_longitude) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid user coordinate asdaewef, can't calculate distance."))
    end
  end
end
