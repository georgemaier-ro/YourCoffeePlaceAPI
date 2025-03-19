require "bigdecimal"

class UserLocation
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :latitude, :longitude

  validates_presence_of :latitude
  validates_presence_of :longitude

  validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def persisted?
    false
  end
end
