require "matrix"
require "bigdecimal"

class CoffeeShop
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include CoordinatesHelper

  attr_accessor :name, :latitude, :longitude, :distance

  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude

  # I wrote this just for fun cause all the coffee shops in the list were Starbucks, I'll leave it here as an easter egg even though its not required
  # validate :premium_coffee_shops_validation
  validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def initialize(name, latitude, longitude)
    @name = name
    @latitude = latitude
    @longitude = longitude
  end

  def persisted?
    false
  end

  def get_distance_to_coffee_shop(user_latitude, user_longitude)
    @distance = calculate_distance(latitude, longitude, user_latitude, user_longitude)
  end

  # Can be extended with other coffee shops other than Starbucks just add their name to the array
  def premium_coffee_shops_validation
    errors.add(:name, "is not a premium coffee shop") unless [ "Starbucks" ].include? name
  end
end
